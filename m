Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWDMQwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWDMQwK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 12:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWDMQwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 12:52:10 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:14311 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1750844AbWDMQwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 12:52:09 -0400
Date: Thu, 13 Apr 2006 18:51:53 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
Subject: [PATCH 0/4] Cleanup of mtd->type and mtd->flags
Message-ID: <20060413165153.GD30574@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there appears to be a great confusion surrounding mtd->type
and mtd->flags.  Various combinations of type and flags are used by
device drivers to give some hints to users.  Some users interpret
these hints as seems to be intended by the drivers, others don't.
Mismatches are caused by both drivers and users being confused and the
whole system being less than clear.

This patchset is part of a larger work trying to clean things up.
Patches are fairly simple and shouldn't need any discussion.

Jörn
