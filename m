Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbVIRQH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVIRQH1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 12:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbVIRQH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 12:07:27 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:56810 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S932108AbVIRQH0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 12:07:26 -0400
Date: Sun, 18 Sep 2005 18:03:29 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Timur <blackdir@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sis695 southbridge support (Asus K8S-MX)
Message-ID: <20050918160329.GA897@electric-eye.fr.zoreil.com>
References: <20050918153818.42941.qmail@web54513.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050918153818.42941.qmail@web54513.mail.yahoo.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur <blackdir@yahoo.com> :
[...]
> My current motherboard (Asus K8S-MX) uses SiS 695
> chipset for southbridge to provide also a SATA/RAID
> controller. To my understanding, current kernel does
> not support this chipset

Please try the sata_sis.c driver of a recent kernel and
report any issue on linux-ide@vger.kernel.org

With this motherboard, you can try the in-kernel sis190
driver too (reports go to netdev@vger.kernel.org for this
one).

--
Ueimor
