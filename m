Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbUK0XsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbUK0XsZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 18:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbUK0XsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 18:48:25 -0500
Received: from beseeingyou.bytemark.co.uk ([212.13.210.26]:31403 "HELO
	beseeingyou.bytemark.co.uk") by vger.kernel.org with SMTP
	id S261366AbUK0XsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 18:48:22 -0500
From: Fred Emmott <mail@fredemmott.co.uk>
To: linux-kernel@vger.kernel.org
Subject: [patch] make root_plug more useful via whitelist
Date: Sat, 27 Nov 2004 23:47:15 +0000
User-Agent: KMail/1.7.50
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411272347.15728.mail@fredemmott.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch: http://fredemmott.co.uk/files/rp.patch

This adds a whitelist of programs such as /bin/login and /sbin/agetty which 
may be ran as root without the USB device prescent. It also includes my 
earlier patch to check the USB device's serial number as well as 
vendor/product.

This is not meant for inclusion; I'd appreciate comments on anything I've done 
wrong, and suggestions on how to make it distribution neutral (at the moment 
it probably only works correctly on slackware) - I'm thinking of adding a 
security/root_plug_relax/ directory containing files such as "slackware.h" 
"redhat.h" etc.

Thanks for your time,

-- 
Fred Emmott
(http://www.fredemmott.co.uk)
