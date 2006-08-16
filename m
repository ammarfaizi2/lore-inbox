Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWHPVC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWHPVC5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 17:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWHPVC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 17:02:57 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:40115 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932223AbWHPVC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 17:02:56 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/3] PM: Use suspend_console in swsusp and make it configureable
Date: Wed, 16 Aug 2006 22:59:00 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608162259.00941.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patches add suspend_console() and resume_console() to the
suspend-to-disk code paths, make it possible to disable the console suspending
and remove the CONFIG_PM_TRACE option from kernel/power/Kconfig .

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

