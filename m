Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751531AbWEaB5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbWEaB5Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 21:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbWEaB5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 21:57:24 -0400
Received: from terminus.zytor.com ([192.83.249.54]:13989 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751528AbWEaB5X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 21:57:23 -0400
Message-ID: <447CF7F5.8010709@zytor.com>
Date: Tue, 30 May 2006 18:57:09 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James.Bottomley@HansenPartnership.com,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: i386 subarchitectures: boot page table flags
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Does any of the i386 subarchitectures actually care about the Accessed and Dirty bits in 
the bootup pagetables (the ones that start at pg0, used before the mm is initialized?)  If 
not, I'd like to speed up booting by setting those bits at initialization time.

	-hpa
