Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273783AbRJEVPK>; Fri, 5 Oct 2001 17:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274070AbRJEVPA>; Fri, 5 Oct 2001 17:15:00 -0400
Received: from [208.129.208.52] ([208.129.208.52]:28691 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S273783AbRJEVOy>;
	Fri, 5 Oct 2001 17:14:54 -0400
Date: Fri, 5 Oct 2001 14:20:01 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: lkml <linux-kernel@vger.kernel.org>
Subject: RT signals and pipe()s ...
Message-ID: <Pine.LNX.4.40.0110051408590.1523-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since i extended the /dev/epoll to manage pipe()s i noticed that rt
signals do not support pipe()s.
The mechanism of event notification fro /dev/epoll is perfectly compatible
with the one used by rt sigs.
Is anyone interested in pipe()s extension to rt sigs ?
The whole patch would be around 20-30 lines add.



- Davide


