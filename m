Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265808AbUFXWH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265808AbUFXWH7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265817AbUFXWFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:05:00 -0400
Received: from mail.kroah.org ([65.200.24.183]:39606 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265760AbUFXVra convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:47:30 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.7
User-Agent: Mutt/1.5.6i
In-Reply-To: <1088113567381@kroah.com>
Date: Thu, 24 Jun 2004 14:46:08 -0700
Message-Id: <10881135683007@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.103.5, 2004/06/14 11:08:54-07:00, rl@hellgate.ch

[PATCH] PCI: Fix PME bits in pci.txt

Signed-off-by: Roger Luethi <rl@hellgate.ch>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/power/pci.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/Documentation/power/pci.txt b/Documentation/power/pci.txt
--- a/Documentation/power/pci.txt	2004-06-24 13:51:03 -07:00
+++ b/Documentation/power/pci.txt	2004-06-24 13:51:03 -07:00
@@ -286,11 +286,11 @@
 +------------------+
 |  Bit  |  State   |
 +------------------+
-|  15   |   D0     |
-|  14   |   D1     |
+|  11   |   D0     |
+|  12   |   D1     |
 |  13   |   D2     |
-|  12   |   D3hot  |
-|  11   |   D3cold |
+|  14   |   D3hot  |
+|  15   |   D3cold |
 +------------------+
 
 A device can use this to enable wake events:

