Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316674AbSHXUVx>; Sat, 24 Aug 2002 16:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316675AbSHXUVw>; Sat, 24 Aug 2002 16:21:52 -0400
Received: from keen.esi.ac.at ([193.170.117.2]:37898 "EHLO keen.esi.ac.at")
	by vger.kernel.org with ESMTP id <S316674AbSHXUVw>;
	Sat, 24 Aug 2002 16:21:52 -0400
Date: Sat, 24 Aug 2002 22:26:04 +0200 (CEST)
From: Gerald Teschl <gerald@esi.ac.at>
To: linux-kernel@vger.kernel.org
Subject: ad1848 causes infinite loop in 2.4.19 
Message-ID: <Pine.LNX.4.44.0208242219360.28661-100000@keen.esi.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have an opl3sa4 sound card which requires the opl2sa2 and
ad1848 modules.

When I try to lood this module it fails to auto-configure the sound card 
(which is a known problem and for which I have submitted patches). But 
then it runs trough the init setup in an infinite loop blocking the 
kernel. In particular it prints

ad1848: OPL3-SA2 WSS mode ad1848 config failed (out of resources?)[-2]

over and over on the console. This did not happen with 2.4.18.

Gerald

PS: My fix for the isapnp activation of the opl3sa4 card did not
show up in the 2.4.19 kernel (with my patch the above problem
will not occure). How do I find out the current status of my
patches. Should I resubmit them? 

