Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbTFTKSw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 06:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbTFTKSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 06:18:52 -0400
Received: from cmu-24-35-32-166.mivlmd.cablespeed.com ([24.35.32.166]:1028
	"EHLO lap.molina") by vger.kernel.org with ESMTP id S262633AbTFTKSv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 06:18:51 -0400
Date: Wed, 18 Jun 2003 06:07:05 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@lap.molina
To: linux-kernel@vger.kernel.org
Subject: Compaq Presario and 2.5.72
Message-ID: <Pine.LNX.4.44.0306180559190.883-100000@lap.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I previously reported two problems with 2.5.71 and my laptop.

One problem was my synaptics touchpad mouse wasn't operating correctly.  
That problem has been fixed.  Thanks.

The other problem was getting my pcmcia ethernet card up and operational.  
The change in the yenta module for the latest bk version of 72 allows it 
to be autoloaded by my RedHat 8.0 system as previously done.  However, 
there is another problem.  Although all the required modules get loaded -- 
pcmcia core, yenta socket, ds, crc32, tulip -- for some reason the dhcp 
client doesn't get brought up to acquire an address for the interface.  It 
may be a problem with the RedHat scripts since running the dhclient 
software manually does its magic.  It is a change in behaviour so I am 
reporting it here also.

