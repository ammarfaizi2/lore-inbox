Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVHBRxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVHBRxl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 13:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVHBRxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 13:53:41 -0400
Received: from pc2033.sks3.muni.cz ([147.251.211.33]:3563 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S261694AbVHBRxe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 13:53:34 -0400
Date: Tue, 2 Aug 2005 19:53:36 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc5 - ACPI regression
Message-ID: <20050802175336.GA2959@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

newly with 2.6.13-rc5 (previous -rc1 was quite ok)

$ time cat /proc/acpi/battery/BAT0/info  
present:                 yes
design capacity:         6000 mAh
last full capacity:      6000 mAh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 600 mAh
design capacity low:     300 mAh
capacity granularity 1:  60 mAh
capacity granularity 2:  60 mAh
model number:            M6A
serial number:            
battery type:            LIon
OEM info:                ASUSTEK

real    0m32.521s
user    0m0.001s
sys     0m0.015s

-- 
Luká¹ Hejtmánek
