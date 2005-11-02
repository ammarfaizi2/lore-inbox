Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbVKBFCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbVKBFCd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 00:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbVKBFCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 00:02:33 -0500
Received: from relay4.usu.ru ([194.226.235.39]:29659 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1751496AbVKBFCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 00:02:32 -0500
Message-ID: <436847DD.5050504@ums.usu.ru>
Date: Wed, 02 Nov 2005 10:00:13 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: tmpfs (documentation?) bug
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.32.0.8; VDF: 6.32.0.132; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Documentation/filesystems/tmpfs.c currently says:

If nr_blocks=0 (or size=0), blocks will not be limited in that instance;
if nr_inodes=0, inodes will not be limited.

However, mounting a tmpfs with "mount -t tmpfs -o size=0 tmpfs 
/root/tmpfs" results in a tmpfs where only zero-sized files can live. So 
either this behaviour should be fixed to be in accordance with the 
documentation, or the documentation should reflect the current behaviour.

-- 
Alexander E. Patrakov
