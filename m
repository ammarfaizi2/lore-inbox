Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWBZSV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWBZSV4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 13:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWBZSV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 13:21:56 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:36626 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751369AbWBZSVz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 13:21:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=UUV5HI89lX2lihJva83gu7ZwbbKIYiZ7hrNbqzEBfJTRNRo8yh/fRwwfU/BaAIraA/nZw2nRCuN7/nxGmTkmmJ06p0/HwgswDn106LAiP4RK9MKv1E7NTEdSxpQXu2EboLsGFUIHCPjEPWtcNhorB7HDFQllLWgksMYHxxNh3Pc=
Date: Sun, 26 Feb 2006 19:21:40 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, sam@ravnborg.org
Subject: Re: Building 100 kernels; we suck at dependencies and drown in
 warnings
Message-Id: <20060226192140.4951f5a0.diegocg@gmail.com>
In-Reply-To: <200602261721.17373.jesper.juhl@gmail.com>
References: <200602261721.17373.jesper.juhl@gmail.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 26 Feb 2006 17:21:17 +0100,
Jesper Juhl <jesper.juhl@gmail.com> escribió:


> 	95 kernels were build with 'make randconfig'.
> 	1 kernel was build with the config I normally use for my own box.
> 	1 kernel was build from 'make defconfig'.
> 	1 kernel was build from 'make allmodconfig'.
> 	1 kernel was build from 'make allnoconfig'.
> 	1 kernel was build from 'make allyesconfig'.


I wonder if it'd be useful a "make compiletest" which developers
are told to run before submitting changes - a target that would compile
a kernel with allyesconfig, another with allnoconfig, allmodconfig 
and a couple of randconfig, with the time it could improve this
kind of errors.

(I tried to do it myself but I don't know swahili well enought to
hack Makefiles)
