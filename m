Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266571AbUBLUIj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 15:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266568AbUBLUIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 15:08:39 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:22162 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S266567AbUBLUIi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 15:08:38 -0500
Subject: Re: Strange boot with multiple identical disks
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Konstantin Kudin <konstantin_kudin@yahoo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040212192848.29083.qmail@web21204.mail.yahoo.com>
References: <20040212192848.29083.qmail@web21204.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1076616510.16375.25.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 12 Feb 2004 14:08:30 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Redhat mounts the file systems by label.  I believe if you modify
/boot/grub/grub.conf and /etc/fstab to use the device names (/dev/hda*)
instead of LABEL=/, etc., then it should boot properly.  After wiping
out hdc, you can change them back to the way they were.
-- 
David Kleikamp
IBM Linux Technology Center

