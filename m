Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270727AbUJURAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270727AbUJURAw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 13:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270661AbUJUQ44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 12:56:56 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:9861 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S270727AbUJUP7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 11:59:38 -0400
Date: Thu, 21 Oct 2004 17:59:35 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
Subject: High precision nanosleep removed?
Message-ID: <Pine.LNX.4.53.0410211755260.12823@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,


the high precision sleep was removed, as this changeset says. Can anybody shed
some more light on why it is a special case after all?

|PatchSet 3949
|Date: 2002/09/26 05:04:43
|Author: torvalds
|Branch: HEAD
|Tag: (none)
|Log:
|Remove busy-wait for short RT nanosleeps. It's a random special case
|and does the wrong thing for higher HZ values anyway.
|BKrev: 3d92875bgaJQe6_FSRDwHLDYHwPTgw
|
|Members:
|        ChangeSet:1.3949->1.3950
|        kernel/timer.c:1.22->1.23



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
