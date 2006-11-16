Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030738AbWKPIWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030738AbWKPIWV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 03:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030753AbWKPIWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 03:22:20 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:58508 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030738AbWKPIWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 03:22:19 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 0/2] Use freezeable workqueues to avoid suspend-related XFS corruptions
Date: Thu, 16 Nov 2006 09:12:49 +0100
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       Nigel Cunningham <nigel@suspend2.net>, David Chinner <dgc@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611160912.51226.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following two patches introduce a mechanism that should allow us to
avoid suspend-related corruptions of XFS without the freezing of bdevs which
Pavel considers as too invasive (apart from this, the freezing of bdevs may
lead to some undesirable interactions with dm and for now it seems to be
supported for real by XFS only).

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

