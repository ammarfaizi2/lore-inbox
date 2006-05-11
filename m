Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030312AbWEKQQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbWEKQQQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 12:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbWEKQQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 12:16:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:43495 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030312AbWEKQQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 12:16:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=splvlztfKwYh2pvmp7pDu0VEhYN+rYfbO5G6CmRVL+W+U2QM9A8jZfU+BX10BDTtvUd6VuDVuIy+ZPxbCa9qE9A6+xGdPr/fXvwa7G02BTlagRpmBqFGyf0o2VyfQsI4B8TK/k+I3CkOEhfzNugg5c9DOAKvOQfrS1Gj5QHGZSg=
Date: Thu, 11 May 2006 20:14:52 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Rik Bobbaers <Rik.Bobbaers@cc.kuleuven.be>, linux-kernel@vger.kernel.org
Subject: Re: fix compiler warning in ip_nat_standalone.c
Message-ID: <20060511161452.GA11194@mipter.zuzino.mipt.ru>
References: <200605111729.48871.Rik.Bobbaers@cc.kuleuven.be> <20060511155537.GF1104@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060511155537.GF1104@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2006 at 05:55:37PM +0200, Jörn Engel wrote:
> On Thu, 11 May 2006 17:29:48 +0200, Rik Bobbaers wrote:
> > 
> > i just made small patch that fixes a compiler warning:
> 
> Just in case Al didn't make it clear enough in the recent thread:
> 
> You cannot fix a compiler warning!

Calm down. It's pretty obvious from patch the warning is usual

	"unused variable foo"

if CONFIG_BAR=n.

Anyway, fix in mainline already.

> Either the code is wrong or it is right.  A compiler warning can
> indicate that code is wrong, or it is a false positive.  If the code
> is wrong, fix the _code_.  If it isn't, ignore the warning or fix the
> _compiler_.
> 
> That said, your patch looks as if it would actually fix the code.  I'm
> not firm enough with NAT to confirm that, though.  So if it fixes the
> code, please state exactly that.

