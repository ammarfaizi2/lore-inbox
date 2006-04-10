Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWDJHv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWDJHv0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 03:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbWDJHv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 03:51:26 -0400
Received: from terramitica.net ([82.230.142.140]:63673 "EHLO
	sunset.terramitica.net") by vger.kernel.org with ESMTP
	id S1751059AbWDJHv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 03:51:26 -0400
Date: Mon, 10 Apr 2006 09:41:58 +0200
From: Yannick PLASSIARD <yan@mistigri.org>
To: linux-kernel@vger.kernel.org
Subject: Reboot notification chain
Message-ID: <20060410074158.GA1979@sunset>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,
	I have a module which registers with the reboot notifier (register_reboot_notifier(...)); but I have a problem : My handler is called with SYS_POWER_OFF when the system is rebooted and is not called with SYS_POWER_OFF when the system is actually powering off.
	My goal is to track power off in order to turn the power off, on a special hardware without APM or ACPI.
	Did I make something wrong ?
Thanks
	Yannick
