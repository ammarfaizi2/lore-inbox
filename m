Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262902AbUE1NIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUE1NIg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 09:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUE1NIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 09:08:36 -0400
Received: from furon.ujf-grenoble.fr ([152.77.2.202]:31962 "EHLO
	furon.ujf-grenoble.fr") by vger.kernel.org with ESMTP
	id S262902AbUE1NIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 09:08:32 -0400
From: Mickael Marchand <mikmak@freenux.org>
To: linux-kernel@vger.kernel.org
Subject: 3ware 32 bits tools on x86-64 kernel
Date: Fri, 28 May 2004 15:00:59 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405281500.59619.mikmak@freenux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is there any chance to get a fix for this :
ioctl32(tw_cli:5923): Unknown cmd fd(5) cmd(0000001f){00} arg(08189318) on /dev/twe0
(that's just the 'info' command in tw_cli)

looks like there is some missing ioctl32/64 conversions there... (I know tw_cli is proprietary 
but the ioctls are GPL ;)

or maybe 3ware people may provide a 64 bits compiled version of their tools ?

otherwise there is no way to use their admin tools at runtime 
(and so one needs to reboot the machine to go into their BIOS to tweak things)

Cheers,
Mik
