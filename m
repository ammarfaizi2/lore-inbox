Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269542AbTHBQIN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 12:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269557AbTHBQIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 12:08:13 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:18191 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S269542AbTHBQIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 12:08:12 -0400
Date: Sat, 2 Aug 2003 18:08:08 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rob Landley <rob@landley.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: More fun with menuconfig...
In-Reply-To: <200308020605.58423.rob@landley.net>
Message-ID: <Pine.LNX.4.44.0308021805400.714-100000@serv>
References: <200308020605.58423.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2 Aug 2003, Rob Landley wrote:

> I fire up make menuconfig and expand the advanced partition menu (setting 
> CONFIG_ADVANCED_PARTITION to y).  MSDOS partition support is NOT set in the 
> newly opened menu, I.E. opening the menu has the side effect of deselecting 
> CONFIG_MSDOS_PARTITION.

The condition prevents the default from being used, remove the unnecessary 
"!PARTITION_ADVANCED" part and you get the result you want.

bye, Roman

