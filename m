Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313402AbSDGRML>; Sun, 7 Apr 2002 13:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313403AbSDGRML>; Sun, 7 Apr 2002 13:12:11 -0400
Received: from imladris.infradead.org ([194.205.184.45]:41230 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S313402AbSDGRMK>; Sun, 7 Apr 2002 13:12:10 -0400
Date: Sun, 7 Apr 2002 18:11:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Steven N. Hirsch" <shirsch@adelphia.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Two fixes for 2.4.19-pre5-ac3
Message-ID: <20020407181154.A1608@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Steven N. Hirsch" <shirsch@adelphia.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204071240360.15439-100000@atx.fast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2002 at 12:43:57PM -0400, Steven N. Hirsch wrote:
> And, unless this is reversed the OpenAFS kernel module won't load (it 
> needs sys_call_table.):

sys_call_table was unexported for a reason - OpenAFS is broken by design
if it messes with the syscall table.

	Christoph

