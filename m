Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265681AbSKKPUc>; Mon, 11 Nov 2002 10:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265677AbSKKPUb>; Mon, 11 Nov 2002 10:20:31 -0500
Received: from ext-nj2gw-2.online-age.net ([216.35.73.164]:31216 "EHLO
	ext-nj2gw-2.online-age.net") by vger.kernel.org with ESMTP
	id <S265673AbSKKPUa>; Mon, 11 Nov 2002 10:20:30 -0500
Message-ID: <A9713061F01AD411B0F700D0B746CA6802FC154B@vacho6misge.cho.ge.com>
From: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>
To: "'Zwane Mwaikambo'" <zwane@holomorphy.com>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>
Cc: "'Corey Minyard'" <cminyard@mvista.com>, linux-kernel@vger.kernel.org
Subject: RE: NMI handling rework
Date: Mon, 11 Nov 2002 10:26:29 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Am I reading this correctly? As long as no one passes back
NOTIFY_STOP_MASK,
>> all handlers are run.

> For sanity's sake stick to running through all of them, there should be no

> partial handling, every registered handler should get serviced once per 
> NMI interrupt.

I agree. Unless there is some good justification for it, I think the
NOTIFY_STOP_MASK stuff should go away.
