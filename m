Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbTLDS0Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 13:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263478AbTLDS0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 13:26:25 -0500
Received: from gaia.cela.pl ([213.134.162.11]:7173 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S263475AbTLDS0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 13:26:21 -0500
Date: Thu, 4 Dec 2003 19:25:50 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: lilo and system maps?
In-Reply-To: <20031204175311.GF16568@rdlg.net>
Message-ID: <Pine.LNX.4.44.0312041923020.26684-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I'm not mistaken the map file specified in map= is -not- the System.map
file of the kernel, it's a lilo specific map file and has nothing to do
with System.map.  Indeed it'll probably overwrite the System.map file.  
you don't want to specify map= anything other than /boot/map unless your
/boot directory is somewhere else.  As for system.map I have my boot
scripts deleting and symbolic linking /boot/System.map to
/boot/System.map-`uname -r` (these files actually exist) right after boot.  
(not sure maybe this isalready done by the standard distribution of RH, I
do remember fooling around with it though...)

Cheers,
MaZe.


