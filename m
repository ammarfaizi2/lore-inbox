Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbVKQWgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbVKQWgO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 17:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbVKQWgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 17:36:14 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:19891 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S964922AbVKQWgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 17:36:13 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/3][Resend] swsusp: improve freeing of memory
Date: Thu, 17 Nov 2005 23:22:14 +0100
User-Agent: KMail/1.8.3
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200511172322.14735.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following series of patches is designed to make swsusp free only as much
memory as necessary to complete the suspend and not as much as possible.
This speeds up the suspend substantially and makes the system much more
responsive after resume, especially on machines with a lot of RAM.

The patches are against 2.6.15-rc1-mm1.

They have been acked by Pavel (Pavel please confirm).

Please apply (please drop any previous iterations of these patches if you have
them queued).

Greetings,
Rafael
