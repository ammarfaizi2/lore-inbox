Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbULAXVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbULAXVF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 18:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbULAXVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 18:21:05 -0500
Received: from adsl.a2000.nu ([80.126.253.168]:3200 "EHLO adsl.a2000.nu")
	by vger.kernel.org with ESMTP id S261487AbULAXVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 18:21:02 -0500
Date: Thu, 2 Dec 2004 00:20:54 +0100 (CET)
From: Stephan van Hienen <kernel@a2000.nu>
To: linux-kernel@vger.kernel.org
Subject: nfs and LBD support (2TB+)
Message-ID: <Pine.LNX.4.61.0412020017550.2774@adsl.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i don't know if this is kernel related ?

server is exporting nfs 2.3TB

/dev/md0              2.3T  959G  1.4T  41% /raid

on the client i see this as 316GB :

storage:/raid         316GB  129GB  187GB  41% /raid

server is running 2.6.10-rc2
client is running 2.6.9-ac11

both have LBD support enabled
(and both are running tao (which is based on rhel 3))

any ideas ?
