Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270226AbTGWSbn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 14:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270385AbTGWSbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 14:31:42 -0400
Received: from 217-124-18-114.dialup.nuria.telefonica-data.net ([217.124.18.114]:48268
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S270226AbTGWSbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 14:31:42 -0400
Date: Wed, 23 Jul 2003 20:46:47 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: Question about module names containing "-" or" "_" characters
Message-ID: <20030723184647.GA22913@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

This is just a curiosity, but I have observed that you can load modules
containing the characters "-" and "_" using any of "-" or "_" in the
module name. In /proc/modules they get reported with the file name, not
with the name used to load them (except, at least, dm-mod.ko, that is
shown as dm_mod).

I don't know if this is expected behaviour, but I report it just in case
nobody else noticed before. I am using Linux kernel 2.6.0-test1 and
module-init-tools version 0.9.11.

Regards,

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test1)
