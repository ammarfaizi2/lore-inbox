Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263382AbTJBOe0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 10:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263367AbTJBOeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 10:34:04 -0400
Received: from NS1.idleaire.net ([65.220.16.2]:65297 "EHLO iasrv1.idleaire.net")
	by vger.kernel.org with ESMTP id S263365AbTJBOeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 10:34:00 -0400
Subject: Don't update flash firmware on 3Com 3CR990
From: Dave Dillow <dave@thedillows.org>
To: linux-kernel@vger.kernel.org
Cc: linux-net@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1065105238.11877.51.camel@dillow.idleaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Oct 2003 10:33:58 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Oct 2003 14:33:59.0076 (UTC) FILETIME=[377ABE40:01C388F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

3Com recently released a driver update CD for Windows that includes an
update to the onboard flash firmware. If you wish to continue using the
cards under Linux, it is VITAL that you do not apply that update. If you
do, the card will no longer load the firmware image the Linux driver
uses.

I hope to with 3Com to resolve the issues, and hope to have a patch
soon.

Just wanted to give everyone a heads-up.
-- 
Dave Dillow <dave@thedillows.org>

