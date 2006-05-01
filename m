Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWEAQt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWEAQt2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 12:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWEAQt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 12:49:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23184 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932144AbWEAQt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 12:49:27 -0400
Subject: Re: [ALSA] add __devinitdata to all pci_device_id
From: Arjan van de Ven <arjan@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: greg@kroah.com, tiwai@suse.de, henne@nachtwindheim.de
In-Reply-To: <200605011511.k41FBUcu025025@hera.kernel.org>
References: <200605011511.k41FBUcu025025@hera.kernel.org>
Content-Type: text/plain
Date: Mon, 01 May 2006 18:49:24 +0200
Message-Id: <1146502164.20760.53.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-01 at 15:11 +0000, Linux Kernel Mailing List wrote:
> commit 396c9b928d5c24775846a161a8191dcc1ea4971f
> tree 447f4b28c2dd8e0026b96025fb94dbc654d6cade
> parent 71b2ccc3a2fd6c27e3cd9b4239670005978e94ce
> author Henrik Kretzschmar <henne@nachtwindheim.de> Mon, 24 Apr 2006 15:59:04 +0200
> committer Jaroslav Kysela <perex@suse.cz> Thu, 27 Apr 2006 21:10:34 +0200
> 
> [ALSA] add __devinitdata to all pci_device_id


are you really really sure you want to do this?
These structures are exported via sysfs for example, I would think this
is quite the wrong thing to make go away silently...



