Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266793AbUHaTAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266793AbUHaTAd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268776AbUHaTAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:00:33 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:16579 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266793AbUHaTA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:00:27 -0400
Message-ID: <2dc3ece804083112007dd8b43a@mail.gmail.com>
Date: Tue, 31 Aug 2004 21:00:23 +0200
From: Peder Stray <peder.stray@gmail.com>
Reply-To: Peder Stray <peder.stray@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: problem with ACPI and suspend
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI works quite ok on my laptop, currently running 2.6.8, but when i
resume from suspend the second time after a boot i get the following
message:

    ACPI-0286: *** Error: No installed handler for fixed event [00000002]

and the acpi subsystems seem to stop sending events, as no scripts
gets called after this. Anyone had similar problems? I really would
like to have working suspend/resume more than once after each reboot
;)

-- 
  Peder Stray
