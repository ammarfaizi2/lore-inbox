Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274653AbRJYQrO>; Thu, 25 Oct 2001 12:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275424AbRJYQrF>; Thu, 25 Oct 2001 12:47:05 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:59425 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S274653AbRJYQq7>; Thu, 25 Oct 2001 12:46:59 -0400
Date: Thu, 25 Oct 2001 12:47:32 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Hawkes <hawkes@oss.sgi.com>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] gcc 3.0.1 warnings about multi-line literals
Message-ID: <20011025124732.A23000@redhat.com>
In-Reply-To: <20011022161527.K23213@redhat.com> <E15vlx2-0003HO-00@the-village.bc.nu> <20011022165157.M23213@redhat.com> <20011025001150.A8776@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011025001150.A8776@twiddle.net>; from rth@twiddle.net on Thu, Oct 25, 2001 at 12:11:50AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2001 at 12:11:50AM -0700, Richard Henderson wrote:
> On Mon, Oct 22, 2001 at 04:51:57PM -0400, Benjamin LaHaise wrote:
> > Which of the following is more readable:
> [...]
> 
> Or (4):
> 
> 	"btsl $0, %0		\n\

Is this a long term supported format?  It's certainly much better than 
the string per line, and if it's going to say around, then I'm willing 
to switch.

		-ben
