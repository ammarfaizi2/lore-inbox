Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265070AbTF2U0g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264899AbTF2UZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:25:03 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:35470
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264449AbTF2UY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:24:57 -0400
Subject: Re: 2.4.21(-ac) ide-disk and hpt366 modules problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030629190409.A22124@sith.mimuw.edu.pl>
References: <20030629190409.A22124@sith.mimuw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056918977.16253.19.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Jun 2003 21:36:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-06-29 at 18:04, Jan Rekorajski wrote:
> Hi,
> There is a chicken-egg problem between ide-disk and hpt366 modules.
> ide-disk should be loaded after chipset driver to detect what disks are
> connected, but hpt366 needs ide-disk loaded because of 372N tricks and
> __ide_do_rw_disk symbol.

Interesting dependancy - I hadn't noticed that one.


