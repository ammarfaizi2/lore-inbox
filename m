Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbUK1CFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbUK1CFd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 21:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbUK1CFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 21:05:32 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15884 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261388AbUK1CF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 21:05:26 -0500
Date: Sun, 28 Nov 2004 03:05:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: {un,}register_key_type are unused
Message-ID: <20041128020523.GC4713@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

I just noticed that {un,}register_key_type in security/keys/key.c are 
EXPORT_SYMBOL'ed but completely unused.

Is any in-kernel usage for them pending, or is a patch to remove these 
functions OK?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

