Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319186AbSHTQb2>; Tue, 20 Aug 2002 12:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319188AbSHTQb2>; Tue, 20 Aug 2002 12:31:28 -0400
Received: from dark.pcgames.pl ([195.205.62.2]:35540 "EHLO dark.pcgames.pl")
	by vger.kernel.org with ESMTP id <S319186AbSHTQb1>;
	Tue, 20 Aug 2002 12:31:27 -0400
Date: Tue, 20 Aug 2002 18:35:27 +0200 (CEST)
From: Krzysztof Oledzki <ole@ans.pl>
X-X-Sender: <ole@dark.pcgames.pl>
To: <linux-kernel@vger.kernel.org>
cc: <marcelo@conectiva.com.br>
Subject: /proc/partitions in 2.4.20-pre3/4
Message-ID: <Pine.LNX.4.33.0208201827510.22200-100000@dark.pcgames.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello :)

There is something wrong with /proc/partitions. It seems that last changes
broken this file:

"cat /proc/partitions |wc -c"  shows that this file has 29167 bytes. First
part of files has lot of \0 characters. With software raid enabled (not
ataraid) it has all md0 - md255 devices (and not only used devices) and
does not have informations for phisical disks (sdXX, hdXX).

Best Regards,


			Krzysztof Oledzki

