Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262831AbUKZXXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbUKZXXD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbUKZTry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:47:54 -0500
Received: from zeus.kernel.org ([204.152.189.113]:4291 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262400AbUKZT2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:28:51 -0500
Date: Thu, 25 Nov 2004 21:54:11 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Dorn Hetzel <kernel@dorn.hetzel.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com
Subject: Re: r8169.c
Message-ID: <20041125205411.GA3204@electric-eye.fr.zoreil.com>
References: <20041119162920.GA26836@lilah.hetzel.org> <20041119201203.GA13522@electric-eye.fr.zoreil.com> <20041120003754.GA32133@lilah.hetzel.org> <20041120002946.GA18059@electric-eye.fr.zoreil.com> <20041122181307.GA3625@lilah.hetzel.org> <20041123144901.GA19005@lilah.hetzel.org> <20041123194740.GA32210@electric-eye.fr.zoreil.com> <20041125220233.GA23850@lilah.hetzel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125220233.GA23850@lilah.hetzel.org>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dorn Hetzel <kernel@dorn.hetzel.org> :
[...]
> I went ahead and remotely rebuilt using gcc 2.95.4 and upon reboot it
> worked long enough to ssh in and then it failed.  So it sounds like the
> version of gcc DOES make a difference :)

Ok, I'll have to audit the driver for the typical inline assembler +
arithmetic ops which 2.95.x dislikes.

--
Ueimor
