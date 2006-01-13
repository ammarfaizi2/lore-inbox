Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161671AbWAMD2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161671AbWAMD2y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161672AbWAMD2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:28:54 -0500
Received: from CPE0050fc332afc-CM00407b861c34.cpe.net.cable.rogers.com ([69.197.25.155]:58336
	"EHLO nuku.localdomain") by vger.kernel.org with ESMTP
	id S1161671AbWAMD2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:28:53 -0500
Date: Thu, 12 Jan 2006 22:28:54 -0500
From: Rashkae <rashkae@tigershaunt.com>
To: adam.nielsen@uq.edu.au
Cc: linux-kernel@vger.kernel.org
Subject: "umount: device is busy" when device is not in use?
Message-ID: <20060113032854.GA3591@tigershaunt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fuser -m /mnt/data will list the process ID of any process using the mount.

If your feeling brave, fuser -mk will just kill them.
