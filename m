Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129199AbQKMOhl>; Mon, 13 Nov 2000 09:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129249AbQKMOhb>; Mon, 13 Nov 2000 09:37:31 -0500
Received: from [63.95.87.168] ([63.95.87.168]:63753 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S129199AbQKMOh2>;
	Mon, 13 Nov 2000 09:37:28 -0500
Date: Mon, 13 Nov 2000 09:37:27 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: linux-kernel@vger.kernel.org
Subject: Modprobe local root exploit
Message-ID: <20001113093727.C1918@xi.linuxpower.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After seeing the modprobe local root exploit today, I asked myself why
kmod executes modprobe with full root and doesn't drop some capabilities
first.

Why? It wouldn't close the hole, but it would narrow it down.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
