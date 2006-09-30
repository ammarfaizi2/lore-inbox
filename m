Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751971AbWI3VVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbWI3VVP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 17:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbWI3VVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 17:21:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12235 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751971AbWI3VVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 17:21:14 -0400
Date: Sat, 30 Sep 2006 14:20:03 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: dtor@insightbb.com
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: appletouch vs. usbhid
Message-Id: <20060930142003.8ba909b1.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.3; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Dmitry:

A user filed a bug here which seems to indicate that hid lacks needed
exclusions for Apple pointers:
 https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=208721
Do you think we should be adding QUIRK_IGNORE for these?
Perhaps conditional on CONFIG_USB_APPLETOUCH?

We used to have those IGNORE quirks for Wacom, but then started to ignore
all Wacoms. We seem to be not at that point with Apple yet, and also they
have varying vendor IDs.

Cheers,
-- Pete
