Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264485AbUAaCev (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 21:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264583AbUAaCev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 21:34:51 -0500
Received: from lgsx13.lg.ehu.es ([158.227.2.28]:14750 "EHLO lgsx13.lg.ehu.es")
	by vger.kernel.org with ESMTP id S264485AbUAaCeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 21:34:50 -0500
Message-ID: <401B144A.4030506@wanadoo.es>
Date: Sat, 31 Jan 2004 03:34:50 +0100
From: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031206 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LINUX KERNEL MAILING LIST <linux-kernel@vger.kernel.org>
Subject: ALSA problem in 2.6.2-rc2 (mpu-401 not loaded)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

I'm getting this in dmesg with recent 2.6.2-rc2 and even with rc2-mm2 
and of course, I get no sound:


snd_intel8x0: Unknown symbol snd_mpu401_uart_new


so I must modprobe manually the mpu-401 driver. Is this the intended 
way? Or must mpu driver gets automounted? In other kernels I have not 
modprobed mpu-401 and the sound was working correctly.

Thanks a lot.

Luis Miguel Garcia
