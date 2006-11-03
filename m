Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752860AbWKCAdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbWKCAdg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 19:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752881AbWKCAdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 19:33:36 -0500
Received: from fmmailgate04.web.de ([217.72.192.242]:31737 "EHLO
	fmmailgate04.web.de") by vger.kernel.org with ESMTP
	id S1752860AbWKCAdf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 19:33:35 -0500
Reveived: from web.de 
	by fmmailgate04.web.de (Postfix) with SMTP id A0D0F2A31F7
	for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2006 01:33:34 +0100 (CET)
Date: Fri, 03 Nov 2006 01:33:34 +0100
Message-Id: <1582262047@web.de>
MIME-Version: 1.0
From: Christoph Anton Mitterer <TOPAS_@web.de>
To: linux-kernel@vger.kernel.org
Subject: Strange problem when copying files
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I've just had the following strange problem. (using kernel 2.6.18.1)
On a FAT32 partition I copied a directory with some big files (about 1,5GB at all) with cp -a .
Afterwards i diffed the results (diff -q -r) and one file was different!!! I copied again,... this time another file was different.
I looked at my logs but they didn't show any suspicious errors (like harddisk or memory issues).

I rebooted,.. tried again,.. an than it worked.

I've fsck'ed the partition but no errors have been reportet.

Any ideas what's the reason for this issue?
_______________________________________________________________________
Viren-Scan für Ihren PC! Jetzt für jeden. Sofort, online und kostenlos.
Gleich testen! http://www.pc-sicherheit.web.de/freescan/?mc=022222

