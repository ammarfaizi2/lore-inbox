Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbWF0FAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbWF0FAl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWF0E76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:59:58 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:32219 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933397AbWF0EkL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:40:11 -0400
From: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2006 14:40:10 +1000
Subject: [Suspend2][ 0/4] Power off routines.
Message-Id: <20060627044010.14736.18813.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Routines used in entering a sleep state after writing the image. We may
enter ACPI S3, S4 or S5 states, or use the non-ACPI powerdown path.
