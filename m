Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423065AbWAMWqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423065AbWAMWqH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423068AbWAMWqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:46:06 -0500
Received: from main.gmane.org ([80.91.229.2]:50401 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1423065AbWAMWqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:46:05 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: [?] PCI BIOS masks some IDs to prevent OS detection?
Date: Fri, 13 Jan 2006 14:45:29 -0800
Message-ID: <20060113144529.56fa3166@darjeeling.triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-223-223.dsl.pltn13.pacbell.net
X-Newsreader: Sylpheed-Claws 1.9.100 (GTK+ 2.8.9; x86_64-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd like to tap some of the Linux-PCI gurus about something weird I've
been helping a friend with...

He recently installed a PCI RAID card, and ever since, his Ethernet
card stopped working. Further investigation revealed that his
Realtek 8139 (10ec:8139) card had become 10ec:0139, and his 3Com Cyclone
card had become 10b7:1055 from 10b7:9055.

Did the PCI bus decide to mask those PCI IDs to prevent some sort of
resource conflict that would ensue from loading an appropriate driver
for these devices?

-- 
Joshua Kwan

