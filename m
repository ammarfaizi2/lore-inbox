Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbULAPOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbULAPOh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 10:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbULAPOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 10:14:36 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:38041 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S261272AbULAPOV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 10:14:21 -0500
Date: Wed, 1 Dec 2004 16:14:18 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: i915 driver - bad reference counting
Message-ID: <20041201151418.GA17357@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I start Xserver using i915 driver and then I shut it down, I've noticed that
reference count is still 1 (not 0 as expected). Why? I have kernel 2.6.10-rc1.
(Could it be used by agpgart? I do not have agpgart as a module)

-- 
Luká¹ Hejtmánek
