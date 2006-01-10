Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWAJGKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWAJGKM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 01:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWAJGKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 01:10:12 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:40605
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750966AbWAJGKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 01:10:11 -0500
Date: Mon, 09 Jan 2006 22:08:36 -0800 (PST)
Message-Id: <20060109.220836.105435044.davem@davemloft.net>
To: sam@mars.ravnborg.org
CC: linux-kernel@vger.kernel.org
Subject: CONFIG_LOCALVERSION_AUTO recently broken
From: "David S. Miller" <davem@davemloft.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For some reason it isn't post-pending the local GIT version
string to the destination module directory so the modules
get installed in the wrong place and upon reboot are not found.

This started happening some time within the last 2 days.

Any ideas? :-)
