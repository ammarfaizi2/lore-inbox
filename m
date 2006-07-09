Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161034AbWGISUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161034AbWGISUS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 14:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWGISUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 14:20:18 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25871 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932375AbWGISUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 14:20:16 -0400
Date: Sun, 9 Jul 2006 20:20:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: sds@tycho.nsa.gov, jmorris@namei.org
Cc: linux-kernel@vger.kernel.org
Subject: selinux: two conditional.h files
Message-ID: <20060709182015.GM13938@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are two conditional.h files:
  security/selinux/include/conditional.h
  security/selinux/ss/conditional.h

This is quite confusing since security/selinux/ss/Makefile contains
  EXTRA_CFLAGS += -Isecurity/selinux/include
and it's therefore easy to misunderstand the effects of an
  #include "conditional.h"

Can you rename one of these two headers?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

