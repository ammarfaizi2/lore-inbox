Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751579AbWHTWIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbWHTWIy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 18:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbWHTWIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 18:08:54 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17863 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751471AbWHTWIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 18:08:53 -0400
Subject: Re: [RFC][PATCH] hwmon:fix sparse warnings + error handling
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Frodo Looijaard <frodol@dds.nl>,
       Philip Edelbrock <phil@netroedge.com>,
       Mark Studebaker <mdsxyz123@yahoo.com>, lm-sensors@lm-sensors.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <44E8C9AE.3060307@gmail.com>
References: <44E8C9AE.3060307@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 20 Aug 2006 23:28:43 +0100
Message-Id: <1156112923.4051.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-08-20 am 22:44 +0200, ysgrifennodd Michal Piotrowski:
> Hi,
> 
> This patch fixes 56 sparse "ignoring return value of 'device_create_file'" warnings. It also adds error handling.
> 

The core of these wants turning into called functions with the extra
checks included, just because of the size it now is.

