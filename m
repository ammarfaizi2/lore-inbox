Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271375AbTGWW6S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 18:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271377AbTGWW6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 18:58:18 -0400
Received: from corky.net ([212.150.53.130]:36583 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S271375AbTGWW6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 18:58:15 -0400
Date: Thu, 24 Jul 2003 02:13:20 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: KERN_ERR "ide: late registration of driver."
In-Reply-To: <1058999419.6891.14.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0307240210050.17172-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Therefore, I don't see why the late registration is an error.  Am I
> > missing something ?
>
> It may change drive ordering. I've not decided if its an error yet but
> its on my todo list to fix it one way or the other. I have a hack fix I
> can give marcelo for 2.4.22 so its not critical path
>

ok, I'll look into it some more.  Could you please send your hack fix for
this ?

btw, isn't it a persistent problem for all cases ?  As far as I can see,
registration will always be late, at least for machines that boot from
ide.

	Yoav Weiss


