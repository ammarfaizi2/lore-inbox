Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbTLIQgT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 11:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265994AbTLIQgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 11:36:18 -0500
Received: from cafe.hardrock.org ([142.179.182.80]:41633 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S264258AbTLIQgR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 11:36:17 -0500
Date: Tue, 9 Dec 2003 09:36:02 -0700 (MST)
From: James Bourne <jbourne@hardrock.org>
To: Yaroslav Klyukin <skintwin@mail.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: HyperThreading with 2.4.23 and Dual Intel Xenon
In-Reply-To: <3FD5E636.3030509@mail.ru>
Message-ID: <Pine.LNX.4.51.0312090932390.630@cafe.hardrock.org>
References: <10wUb-1mR-37@gated-at.bofh.it> <10xGt-38t-29@gated-at.bofh.it>
 <3FD5E636.3030509@mail.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003, Yaroslav Klyukin wrote:

> Marcelo Tosatti wrote:
> >>we compiled 2.4.23 for 2 cpus but we don't get Hyperthreading working.
> >>with 2.4.20 and the machine, it work without probs.
> >>
> >>Any ideas? 
> 
> Maybe you need to enable ACPI.

Hi,
There has also been an issue identified where HT will not be detected
correctly with 2.4.23 unless you apply a patch or set your number of CPUs to
8 instead of 2...

Please try the patch at
http://www.hardrock.org/kernel/current-updates/linux-2.4.23-updates.patch

as it contains this as well as other fixes.

Regards
James

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  
