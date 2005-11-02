Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbVKBA2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbVKBA2B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 19:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbVKBA2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 19:28:01 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:50828 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751476AbVKBA2B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 19:28:01 -0500
Subject: Problem with the default IOSCHED
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 02 Nov 2005 01:28:02 +0100
Message-Id: <1130891282.5048.50.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

by accident I selected the anticipatory IO scheduler as default in my
kernel config, but only the CFQ was built in. The anticipatory and
deadline were only available as modules. This caused an oops at boot.
After selecting CFQ as default schedule and a recompile and reboot
everything was fine again.

Regards

Marcel


