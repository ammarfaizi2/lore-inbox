Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVCMDJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVCMDJP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 22:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVCMDJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 22:09:15 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55813 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261727AbVCMDJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 22:09:11 -0500
Date: Sun, 13 Mar 2005 04:09:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: unexport phys_proc_id?
Message-ID: <20050313030910.GO3814@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

more than 2 months ago, you EXPORT_SYMBOL'ed phys_proc_id with the 
following comment:

   This is needed for the powernow k8 driver to manage AMD dual core systems.

This driver still doesn't use phys_proc_id today.

Is this obsolete and the EXPORT_SYMBOL can be removed again?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

