Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbTFJUCg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbTFJUA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:00:59 -0400
Received: from gherkin.frus.com ([192.158.254.49]:57218 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S262273AbTFJT7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 15:59:31 -0400
Subject: Re: 2.5.70: AXIS usb flash disk problem
To: linux-kernel@vger.kernel.org
Date: Tue, 10 Jun 2003 15:13:11 -0500 (CDT)
Cc: mdharm-usb@one-eyed-alien.net
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20030610201311.013674F0C@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Original problem summary: plug in USB flash disk on 2.5.70 SCSI system,
	and watch machine lock up solid.

Followup test results: 
	Also broken on 2.5.70 IDE system, although lockup doesn't
	occur until you attempt to access (mount) the disk.

	Works fine with 2.4.20 on both SCSI and IDE systems to which
	I have access.

Matthew (and other usb-storage folks): any idea what's going on here?
Problem seems to point to something in the SCSI emulation layer, which
makes a little sense considering the ide-scsi folks went through
similar pain not long ago.  Thanks!

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
