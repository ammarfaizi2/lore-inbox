Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbULBAo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbULBAo1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 19:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbULBAo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 19:44:27 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:9126 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261520AbULBAoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 19:44:25 -0500
Subject: Re: [2.6 patch] OSS sb_card.c: no need to include mca.h
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Paul Laufer <paul@laufernet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041201215012.GW2650@stusta.de>
References: <20041201215012.GW2650@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101944325.30819.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Dec 2004 23:38:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-12-01 at 21:50, Adrian Bunk wrote:
> I didn't find any reason why this file includes mca.h .
> 

It certainly used to need it to build MCA bus soundblaster support.
Whether it still does in 2.6 I don't know. I assume you tried an MCA
build of OSS ?

