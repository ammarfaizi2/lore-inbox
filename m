Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268739AbUJKJiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268739AbUJKJiO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 05:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268737AbUJKJiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 05:38:14 -0400
Received: from r3az252.chello.upc.cz ([213.220.243.252]:2432 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S268735AbUJKJiK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 05:38:10 -0400
Message-ID: <416A5480.4060901@ribosome.natur.cuni.cz>
Date: Mon, 11 Oct 2004 11:38:08 +0200
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040914
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc4: PnPBIOS: Missing SMALL_TAG_ENDDEP tag
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  you have asked to test latest patch, so here's something I haven't seen with -rc3:

Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f5230
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x5e1a, dseg 0xf0000
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PNPBIOS fault.. attempting recovery.
PnPBIOS: Warning! Your PnP BIOS caused a fatal error. Attempting to continue
PnPBIOS: You may need to reboot with the "nobiospnp" option to operate stably
PnPBIOS: Check with your vendor for an updated BIOS
PnPBIOS: get_dev_node: unexpected status 0x28
PnPBIOS: 12 nodes reported by PnP BIOS; 12 recorded by driver

I use ASUS P4C800E-Deluxe mainboard and this machine a pending bug at http://bugzilla.kernel.org/show_bug.cgi?id=2056 .
The bug is I believe minor.
Martin
Please Cc: me in replies.
