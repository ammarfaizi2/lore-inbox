Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965099AbVINJGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbVINJGG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbVINJGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:06:06 -0400
Received: from nproxy.gmail.com ([64.233.182.205]:31021 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965096AbVINJGF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:06:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PN38Iu9jWoz/8YshQFSxG+O6Xeh7/kzkIzOgyoQXucAMnSJZ776+CXCM9fwTT5m9DX6TV/bevFO66F3qekCR7E5QBCKrFpUAC5oajxeyzJzAgJDVg3w2KsTTpXS1zM8T+opWN3JQihSXWgjboXRzEPx/19cCc1EWUe5emSbCs0w=
Message-ID: <2cd57c900509140205572f19b7@mail.gmail.com>
Date: Wed, 14 Sep 2005 17:05:57 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@gmail.com
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild-permanently-fix-kernel-configuration-include-mess.patch added to -mm tree
Cc: rmk+lkml@arm.linux.org.uk, rmk+kernel@arm.linux.org.uk, sam@ravnborg.org,
       mm-commits@vger.kernel.org
In-Reply-To: <200509140841.j8E8fG1w022954@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509140841.j8E8fG1w022954@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/05, akpm@osdl.org <akpm@osdl.org> wrote:
> 
> The patch titled
> 
>      kbuild: permanently fix kernel configuration include mess.
> 
> has been added to the -mm tree.  Its filename is
> 
>      kbuild-permanently-fix-kernel-configuration-include-mess.patch
> 
> 
> From: Russell King <rmk+lkml@arm.linux.org.uk>
> 
> Include autoconf.h into every kernel compilation via the gcc command line
> using -imacros.  This ensures that we have the kernel configuration
> included from the start, rather than relying on each file having #include
> <linux/config.h> as appropriate.  History has shown that this is something
> which is difficult to get right.

Not all compilations need config.h included and this slows down gratuitously.
-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
