Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268539AbUHYGg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268539AbUHYGg5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 02:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268544AbUHYGg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 02:36:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41673 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268539AbUHYGg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 02:36:56 -0400
Date: Tue, 24 Aug 2004 23:36:48 -0700
From: "David S. Miller" <davem@redhat.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: rddunlap@osdl.org, lcaron@apartia.fr, linux-kernel@vger.kernel.org
Subject: Re: TG3(Tigoon) & Kernel 2.4.27
Message-Id: <20040824233648.53eb7c30.davem@redhat.com>
In-Reply-To: <20040825044551.GH1456@alpha.home.local>
References: <412B5B35.7020701@apartia.fr>
	<20040824092533.65cb32da.rddunlap@osdl.org>
	<20040824113407.287f0408.davem@redhat.com>
	<20040825044551.GH1456@alpha.home.local>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2004 06:45:52 +0200
Willy Tarreau <willy@w.ods.org> wrote:

> I think that he's using a debian kernel

I knew he was using a debian kernel from the moment I saw
the string "tg3_request_firmware()" in the very first email
of this thread.

I pity the poor fool who wishes to netboot his system using
a tg3 card and use an nfsroot with Debian.  Kind of hard to
get the card firmware from the filesystem in that case.

I guess these debian kernel folks replace the BIOS on their
system with one they have the sources for as well.

The tg3 firmware is just a bunch of MIPS instructions.
I guess if I ran objdump --disassemble on the image and
used the output of that in the tg3 driver and "compiled
that source" they'd be happy.  And this makes the situation
even more ludicrious.
