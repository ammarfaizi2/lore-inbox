Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbUK2Qlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbUK2Qlq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 11:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbUK2Qlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 11:41:46 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:34456 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261758AbUK2Qld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 11:41:33 -0500
Date: Mon, 29 Nov 2004 17:41:30 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] dynamic syscalls revisited
In-Reply-To: <20041129151741.GA5514@infradead.org>
Message-ID: <Pine.LNX.4.53.0411291740390.30846@yvahk01.tjqt.qr>
References: <1101741118.25841.40.camel@localhost.localdomain>
 <20041129151741.GA5514@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I've seen previous attempts to get dynamic system calls into the kernel
>> and they just get dumped, but usually with good reason.  They require a
>> change to all architectures quite drastically and is usually a problem
>> implementing them for the module to use them.
>
>Actually they were dumped because dynamically syscalls are a really bad
>idea, not because of implementation issues.

I do not see how dsyscalls could be better than static ones, so they are
one-on-one. Maybe someone could elaborate why they are "a really bad idea"?



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
