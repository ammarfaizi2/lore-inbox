Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130755AbQKINxS>; Thu, 9 Nov 2000 08:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130758AbQKINxI>; Thu, 9 Nov 2000 08:53:08 -0500
Received: from dialup038.wien.atnet.at ([194.152.171.38]:13184 "EHLO
	ghanima.xxx") by vger.kernel.org with ESMTP id <S130755AbQKINxD>;
	Thu, 9 Nov 2000 08:53:03 -0500
Date: Thu, 9 Nov 2000 14:56:05 +0100
From: therapy <therapy@endorphin.org>
To: linux-kernel@vger.kernel.org
Subject: arch/i386/lib/mmx.c no symbols
Message-ID: <20001109145605.A507@ghanima.xxx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/lib/mmx.c does not export modversioned symbols.

any module using include/asm-i386/[string.h/string-486.h/page.h]
with 3DNOW enabled will fail to load.

-therp
(not-subscribed to the list, send a cc to me,
if you reply)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
