Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272382AbTHIP3E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 11:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272383AbTHIP3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 11:29:04 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:52912 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S272382AbTHIP3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 11:29:02 -0400
Date: Sat, 9 Aug 2003 17:29:11 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org
Cc: Roman Zippel <zippel@linux-m68k.org>, qemu-devel@nongnu.org
Subject: 2.6.0-test3 VGA console inevitable?
Message-ID: <20030809152911.GA5396@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Roman Zippel <zippel@linux-m68k.org>, qemu-devel@nongnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All!

it seems that the build system now does not allow
to disable the VGA Console anymore :(

removing 
  CONFIG_VGA_CONSOLE=y

or replacing with 
  # CONFIG_VGA_CONSOLE is not set

gets automatically changed back to 
  CONFIG_VGA_CONSOLE=y

on make?

system is x86, but what if I do not have a vga console at all?

best,
Herbert

