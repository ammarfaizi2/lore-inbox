Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287306AbSAUQZM>; Mon, 21 Jan 2002 11:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287344AbSAUQZD>; Mon, 21 Jan 2002 11:25:03 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:16089 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S287306AbSAUQYu>; Mon, 21 Jan 2002 11:24:50 -0500
Date: Mon, 21 Jan 2002 17:24:16 +0100 (CET)
From: Pascal Lengard <pascal.lengard@wanadoo.fr>
To: linux-kernel@vger.kernel.org
cc: rml@tech9.net
Subject: preemption and pccard ?
In-Reply-To: <Pine.LNX.4.33.0110301145500.22376-100000@h2o.chezmoi.fr>
Message-ID: <Pine.LNX.4.44.0201211712220.14037-100000@fw.chezmoi.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a problem running kernel 2.4.17 patched with 
http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/preempt-kernel-rml-2.4.17-1.patch

First I must say that I run 2.4.17 + international patches (crypto fs)
and freeswan. I know I should test with just preempt to see what happens,
but I have to find time ... and 2.4.17+crypto+freeswan works correctly.

the story:
I patched in this order:
2.4.17+preempt+crypto+freeswan
The symptom is: only slot 00 of pccard works. inserting a card in slot 01
does nothing although yenta_socket reports 2 slots found in /var/log/messages
(I see no difference in logs between working kernel and broken one).

Now I am using a kernel patched in this order:
2.4.17+crypto+freeswan and both slots (00 and 01) behave correctly.

Hardware is dell latitude C600 (with apm problem on standard kernel by the way ...)

Does anyone see some light there ?
Could the symptom really be linked to preempt patch ?
I'd love to see if preempt really is interesting on a laptop ...
If it does interest someone, I could test just 2.4.17+preempt just to see ...


Pascal

