Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTDTN5u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 09:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263581AbTDTN5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 09:57:50 -0400
Received: from mail1.ewetel.de ([212.6.122.16]:60654 "EHLO mail1.ewetel.de")
	by vger.kernel.org with ESMTP id S263580AbTDTN5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 09:57:49 -0400
To: linux-kernel@vger.kernel.org
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH 2.5] report unknown NMI reasons only once
In-Reply-To: <20030420052007$742b@gated-at.bofh.it>
References: <20030419232008$7a8a@gated-at.bofh.it> <20030419232008$6291@gated-at.bofh.it> <20030419232008$5be3@gated-at.bofh.it> <20030420052007$742b@gated-at.bofh.it>
Date: Sun, 20 Apr 2003 16:09:35 +0200
Message-Id: <E197FVf-0000GS-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Apr 2003 07:20:07 +0200, you wrote:

>> Beats me as to what could be wrong. It's not a memory problem and the
>> CPU does not overheat.
>> 
>> I'll go patch the kernel for my personal use then, but I'm not the only
>> one seeing those messages without any system problems.
> 
> It's all fun and games until NMIs turn into MCEs...

I have the MCE polling stuff enabled and will keep an eye on it. So far
I suspect flaky motherboard design (Athlon XPs didn't even exist when
this piece of hardware was designed).

It's definitely CPU-related since it never happened with the Duron
processor that I used before.

-- 
Ciao,
Pascal
