Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317226AbSEXRtH>; Fri, 24 May 2002 13:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317228AbSEXRtG>; Fri, 24 May 2002 13:49:06 -0400
Received: from imladris.infradead.org ([194.205.184.45]:13834 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317226AbSEXRtE>; Fri, 24 May 2002 13:49:04 -0400
Date: Fri, 24 May 2002 18:49:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: asm/timex.h
Message-ID: <20020524184903.B24780@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20020524193345.A21559@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 07:33:45PM +0200, Vojtech Pavlik wrote:
> Hi!
> 
> I have several questions about asm/timex.h
> 
> 1) Who uses it? The kernel certainly doesn't. Perhaps NTP?

The kernel does.  Thanks to the sched.h mess it's even implictly
included in almost any file..

> 3) What if an architecture doesn't have a compile-time known
>    CLOCK_TICK_RATE? I suppose I cannot just #define it to a variable,
>    because the kernel doesn't use it, and that probably means userland
>    does ...

The kernel DOES use it.  grep(1) is your friend.

