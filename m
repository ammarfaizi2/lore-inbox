Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313850AbSDPTri>; Tue, 16 Apr 2002 15:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313811AbSDPTrh>; Tue, 16 Apr 2002 15:47:37 -0400
Received: from imladris.infradead.org ([194.205.184.45]:50693 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S313850AbSDPTrg>; Tue, 16 Apr 2002 15:47:36 -0400
Date: Tue, 16 Apr 2002 20:47:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre7
Message-ID: <20020416204719.A11687@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0204160049130.18896-100000@freak.distro.conectiva> <20020416161722.F25328@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 04:17:22PM +0200, Andrea Arcangeli wrote:
> On Tue, Apr 16, 2002 at 12:50:13AM -0300, Marcelo Tosatti wrote:
> > <hch@infradead.org> (02/04/15 1.409)
> > 	[PATCH] unlock buffer_head _after_ end_kio_request
> 
> This is wrong.

Yes.  A short conversation with bcrl even uncovered why it is wrong
and why my reason for doing it is wrong..

Marcelo, you you please cset -x this one?

	Christoph

