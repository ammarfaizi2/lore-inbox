Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264761AbTFAXRR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 19:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264762AbTFAXRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 19:17:17 -0400
Received: from miranda.zianet.com ([216.234.192.169]:62212 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S264761AbTFAXRQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 19:17:16 -0400
Subject: Re: Question about style when converting from K&R to ANSI C.
From: Steven Cole <elenstev@mesatop.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <16090.34236.144618.434700@argo.ozlabs.ibm.com>
References: <1054446976.19557.23.camel@spc>
	 <20030601132626.GA3012@work.bitmover.com>
	 <20030601134942.GA10750@alpha.home.local>
	 <20030601140602.GA3641@work.bitmover.com> <1054479734.19552.51.camel@spc>
	 <16090.34236.144618.434700@argo.ozlabs.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054510225.19551.116.camel@spc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 01 Jun 2003 17:30:25 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-01 at 17:01, Paul Mackerras wrote:
> Steven Cole writes:
> 
> > Here is a snippet of a patch from arch/ppc/xmon/ppc-opc.c:
> 
> Given that that file is a direct lift from binutils, I would rather
> update it with the latest version from binutils than waste time on
> reformatting, if it really bothers you.
> 
> My opinion is that changing code that works and that doesn't need
> attention is a waste of time.  If you're working on some code (or even
> if you are just trying to understand it and you want to make it clearer),
> then fine, reformat/re-indent/fix argument declarations/whatever, but
> if you're not, find something more productive to do.
> 
> Paul.
> 
The only purpose was to convert from K&R style:

int foo(bar, baz)
long bar;
long baz;
{
}

to ANSI C style:

int foo(long bar, long baz)
{
}

The purpose of the above is that Linus's new sparse checker purposefully
ignores K&R style, and he has indicated a willingness to accept patches
for the conversion.  In fact, he began the conversion himself.

If you'd rather me not touch arch/ppc/xmon/ppc-opc.c and xmon.c, then I
won't.  I was about ready to send those patches to you.  Please let me
know what you'd prefer.  The default will be no action. Thanks.

Steven

