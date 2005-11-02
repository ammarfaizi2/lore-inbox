Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965089AbVKBPcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbVKBPcJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 10:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965091AbVKBPcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 10:32:09 -0500
Received: from ra.sai.msu.su ([158.250.29.2]:36807 "EHLO ra.sai.msu.su")
	by vger.kernel.org with ESMTP id S965089AbVKBPcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 10:32:08 -0500
Date: Wed, 2 Nov 2005 18:32:06 +0300 (MSK)
From: Evgeny Rodichev <er@sai.msu.su>
To: linux-kernel@vger.kernel.org
Subject: x86_64 mce_log question
Message-ID: <Pine.GSO.4.63.0511021822010.28234@ra.sai.msu.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

at Opteron-based x86_64 system sometimes I get message

Machine check events logged

(non-fatal). How can I read the correspondent events? From the source
code (arch/x86_64/kernel/mce.c) it sounds like some misc device with
MISC_MCELOG_MINOR 227 is registered (with name "mcelog"?), but there is
no such device under /dev.

Thank you.
_________________________________________________________________________
Evgeny Rodichev                          Sternberg Astronomical Institute
email: er@sai.msu.su                              Moscow State University
Phone: 007 (095) 939 2383
Fax:   007 (095) 932 8841                       http://www.sai.msu.su/~er
