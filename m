Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbVIENRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbVIENRm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 09:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbVIENRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 09:17:42 -0400
Received: from outmx006.isp.belgacom.be ([195.238.2.99]:38588 "EHLO
	outmx006.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1751250AbVIENRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 09:17:42 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.13 repeated ACPI events?
Date: Mon, 5 Sep 2005 15:16:58 +0200
User-Agent: KMail/1.8.1
References: <Pine.LNX.4.63.0509050853310.3389@p34>
In-Reply-To: <Pine.LNX.4.63.0509050853310.3389@p34>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509051516.58185.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing repeated ACPI events too, but of the battery kind:

[Mon Sep  5 15:13:52 2005] received event "battery BAT2 00000080 00000001"
[Mon Sep  5 15:13:52 2005] completed event "battery BAT2 00000080 00000001"
[Mon Sep  5 15:14:53 2005] received event "battery BAT1 00000080 00000001"
[Mon Sep  5 15:14:53 2005] completed event "battery BAT1 00000080 00000001"
[Mon Sep  5 15:14:53 2005] received event "battery BAT2 00000080 00000001"
[Mon Sep  5 15:14:53 2005] completed event "battery BAT2 00000080 00000001"
[Mon Sep  5 15:15:55 2005] received event "battery BAT1 00000080 00000001"
[Mon Sep  5 15:15:55 2005] completed event "battery BAT1 00000080 00000001"
[Mon Sep  5 15:15:55 2005] received event "battery BAT2 00000080 00000001"
[Mon Sep  5 15:15:55 2005] completed event "battery BAT2 00000080 00000001"

going on forever and ever...

Jan
-- 
Publishing a volume of verse is like dropping a rose petal down the
Grand Canyon and waiting for the echo.
