Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265377AbUAHQTJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 11:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265389AbUAHQTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 11:19:09 -0500
Received: from mail2-116.ewetel.de ([212.6.122.116]:39388 "EHLO
	mail2.ewetel.de") by vger.kernel.org with ESMTP id S265377AbUAHQTH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 11:19:07 -0500
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Relocation overflow with modules on Alpha
In-Reply-To: <1bKho-37e-25@gated-at.bofh.it>
References: <1arJl-l5-9@gated-at.bofh.it> <1aNAg-5UM-29@gated-at.bofh.it> <1bKho-37e-25@gated-at.bofh.it>
Date: Thu, 8 Jan 2004 17:18:52 +0100
Message-Id: <E1Aecs0-0000Ew-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jan 2004 16:30:46 +0100, you wrote in linux.kernel:

> I'm thinking about some __init tricks in lib/inflate.c.
> What about this patch? It has a nice side effect - the "inflate"
> code gets freed after init is done.

Isn't this code also used for zisofs?

-- 
Ciao,
Pascal
