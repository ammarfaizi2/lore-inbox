Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265954AbTFWFcf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 01:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265956AbTFWFcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 01:32:35 -0400
Received: from f19.mail.ru ([194.67.57.49]:32009 "EHLO f19.mail.ru")
	by vger.kernel.org with ESMTP id S265954AbTFWFce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 01:32:34 -0400
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.5.73 - SCSI hosts order with scsihosts
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Mon, 23 Jun 2003 09:46:40 +0400
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19UKA4-000CeM-00.arvidjaar-mail-ru@f19.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, scsihosts has been removed. It was ugly, no doubt.

Could any body explain how can I use other means mentioned in changelog
to force particular scsi hosts ordering. I.e. I want to make sure
my ide-scsi is always host 0 and ppa is always host 1 irrespectively
in which order they were loaded.

Said changelog:

	This feature is seriously racy, and doesn't work under many
	circumstances.  As we have proper ways to find devices by their
	their locical naming (UUID, fs label) or physical connectivity
	(scsidev, sysfs) it shouldn't be nessecary anymore.


Thank you

-andrey
