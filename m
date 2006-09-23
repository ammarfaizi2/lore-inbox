Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWIWKMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWIWKMY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 06:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWIWKMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 06:12:23 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:14784 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751213AbWIWKMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 06:12:23 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm] swsusp: Add support for swap files
Date: Sat, 23 Sep 2006 11:57:59 +0200
User-Agent: KMail/1.9.1
Cc: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200609231158.00147.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following series of patches makes swsusp support swap files.

For now, it is only possible to suspend to a swap file using the in-kernel
swsusp and the resume cannot be initiated from an initrd.

[Note to Pavel: I have added a couple of paragraphs to the documentation to
clarify some things pointed out by Dave, but I hope the ACK still applies. ;-) ]

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

