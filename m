Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbTEFGq2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 02:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbTEFGq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 02:46:28 -0400
Received: from h234n2fls24o900.telia.com ([217.208.132.234]:51690 "EHLO
	oden.fish.net") by vger.kernel.org with ESMTP id S262403AbTEFGq1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 02:46:27 -0400
Date: Tue, 6 May 2003 09:00:06 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.69
Message-Id: <20030506090006.74cb7cc7.lista1@telia.com>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mon, 5 May 2003 06:19:51 +0200 I wrote:

>/tmp/ccKug4Ma.s:1102: Error: Unknown pseudo-op:  `.incbin'
>/tmp/ccKug4Ma.s:1107: Error: Unknown pseudo-op:  `.incbin'
>make[1]: *** [arch/i386/kernel/vsyscall.o] Error 1
>make: *** [arch/i386/kernel] Error 2

Turns out I got bitten by too old binutils. Could you do a "feet/metre" convertion in
Documentation/Changes under _Current Minimal Requirements_, something like:

o  binutils               2.9.5.0.25              # ld -v
+or
+o GNU/binutils           2.13.(wherever 'as' got to know about incbin)

I had the GNU 2.11.2 which is higher than 2.9.x... right ;-)

Regards,
Mats Johannesson
