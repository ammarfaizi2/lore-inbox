Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132419AbRDPXwb>; Mon, 16 Apr 2001 19:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132421AbRDPXwV>; Mon, 16 Apr 2001 19:52:21 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38156 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132419AbRDPXwH>; Mon, 16 Apr 2001 19:52:07 -0400
Subject: Re: [PATCH] Unisys pc keyboard new keys patch, kernel 2.4.3
To: acahalan@cs.uml.edu (Albert D. Cahalan)
Date: Tue, 17 Apr 2001 00:53:15 +0100 (BST)
Cc: dwguest@win.tue.nl (Guest section DW),
        ebiederm@xmission.com (Eric W. Biederman),
        hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <200104161952.f3GJqWn07999@saturn.cs.uml.edu> from "Albert D. Cahalan" at Apr 16, 2001 03:52:32 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pIo2-0001G8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, but they could be. Changing the Linux keycodes is a major
> break with compatibility. If the Linux keycodes are to be changed,
> then they ought to be become something that would allow XFree86
> to become keyboard-independent. Why invent yet another encoding?

You dont need to break compatibility. We have cooked, raw, semi-raw type modes
for keyboard right now. We just need to add semi-raw-extended and raw-extended

