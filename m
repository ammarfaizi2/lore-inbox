Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbTEFNBg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 09:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbTEFNBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 09:01:36 -0400
Received: from mxout4.netvision.net.il ([194.90.9.27]:21742 "EHLO
	mxout4.netvision.net.il") by vger.kernel.org with ESMTP
	id S262720AbTEFNBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:01:35 -0400
Date: Tue, 06 May 2003 16:26:10 +0200
From: Nir Livni <nir_l3@netvision.net.il>
Subject: shared objects, ELFs and memory usage
To: linux-kernel@vger.kernel.org
Message-id: <001401c313db$767bdb60$ded1b3d4@pinguin>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
If this is not the mailing list to ask this question - please let me know
where should I ask it.

I have an executable whose size is almost 2MB, and it uses a shared object
that is almost 2MB.
when I run the process, I see (using "top") that the amount of "used memory"
raises with 4MB. (make sence...). the process seem to share 2MB ("shared"
column).

When the process forks, it seems that the amount of "used memory" raises
with 4MB again.

Does it mean the shared object is not really shared ? That doesn't make
sence...

Help is appreciated.
Please CC me because I am not subscribed.

Thanks,
Nir

