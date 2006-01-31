Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751537AbWAaVmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbWAaVmp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 16:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbWAaVmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 16:42:45 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:5301 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751535AbWAaVmo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 16:42:44 -0500
Subject: Re: [2.6 patch] ISDN_CAPI_CAPIFS related cleanups
From: Marcel Holtmann <marcel@holtmann.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: kkeil@suse.de, kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060131213306.GG3986@stusta.de>
References: <20060131213306.GG3986@stusta.de>
Content-Type: text/plain
Date: Tue, 31 Jan 2006 22:44:04 +0100
Message-Id: <1138743844.3968.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> This patch contains the following cleanups:
> - move the help text to the right option
> - replace some #ifdef's in capi.c with dummy functions in capifs.h
> - use CONFIG_ISDN_CAPI_CAPIFS_BOOL in one place in capi.c

I actually still like to see capifs removed completely. It is not really
needed if you gonna use udev. The only thing that it is doing, is to set
the correct permissions and make sure that the device nodes are created.
And with a 2.6 kernel this can be all done by udev.

Regards

Marcel


