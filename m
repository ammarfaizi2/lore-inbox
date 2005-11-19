Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbVKSMwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbVKSMwE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 07:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbVKSMwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 07:52:04 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:33244 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751416AbVKSMwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 07:52:03 -0500
Subject: Re: Kernel panic: Machine check exception
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Avuton Olrich <avuton@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3aa654a40511190145v6f4df755wf16673050d077edb@mail.gmail.com>
References: <3aa654a40511190145v6f4df755wf16673050d077edb@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 19 Nov 2005 13:24:11 +0000
Message-Id: <1132406652.5238.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-11-19 at 01:45 -0800, Avuton Olrich wrote:
> CPU 0: Machine Check Exception
> TSC 17c72bcfba8               4 Bank 4: b200000000070F0F
> Kernel panic - not syncing: Machine check


Thats almost certainly a hardware fault. Machine checks are signalled
when the processor finds itself in a "can't happen" type of state.


