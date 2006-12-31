Return-Path: <linux-kernel-owner+w=401wt.eu-S1030369AbWLaRk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbWLaRk3 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 12:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbWLaRk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 12:40:29 -0500
Received: from main.gmane.org ([80.91.229.2]:50267 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030369AbWLaRk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 12:40:28 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: [RFC] MTD driver for MMC cards
Date: Sun, 31 Dec 2006 17:40:13 +0000 (UTC)
Message-ID: <en8slt$i14$1@sea.gmane.org>
References: <200612281418.20643.arnd@arndb.de> <4597ADD2.90700@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: pan 0.119 (Karma Hunters)
Cc: linux-mtd@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Dec 2006 13:32:18 +0100, Pierre Ossman wrote:

> Arnd Bergmann wrote:
 
 
> I'm a complete MTD noob, but what uses does the MTD layer have besides
> JFFS2. If it's none, than this advantage isn't that big of a deal.
> 
AFAIK MTD is for device where erase is need to managed in "software" :
http://www.linux-mtd.infradead.org/faq/general.html


For SD card, doesn't a microcontroller on the card hide this, and make the
sd card acts like a normal block device (no need to erase a block before
writing it)?

