Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266720AbUFYMNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266720AbUFYMNW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 08:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266724AbUFYMNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 08:13:22 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:63398 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S266720AbUFYMNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 08:13:19 -0400
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Collapse ext2 and 3 please
In-Reply-To: <40DC1513.2070706@comcast.net>
References: <40DB605D.6000409@comcast.net> <40DBED77.6090704@hist.no> <40DC0CE0.6040509@comcast.net> <20040625114105.GA28892@infradead.org> <40DC1192.7030006@comcast.net> <1088165028.16286.59.camel@imp.csi.cam.ac.uk> <1088165028.16286.59.camel@imp.csi.cam.ac.uk> <40DC1513.2070706@comcast.net>
Message-Id: <E1Bdpa3-0006av-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Date: Fri, 25 Jun 2004 13:13:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David van Hoose wrote:
>All ext3 partitions are labeled as ext3. It still panics.

The kernel doesn't read fstab. Try 

tune2fs -l /dev/whatever | grep -i journal

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
