Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758468AbWK1Mhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758468AbWK1Mhb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 07:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758610AbWK1Mhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 07:37:31 -0500
Received: from il.qumranet.com ([62.219.232.206]:43681 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758468AbWK1Mhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 07:37:31 -0500
Message-ID: <456C2D89.4050508@qumranet.com>
Date: Tue, 28 Nov 2006 14:37:29 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: kvm-devel@lists.sourceforge.net
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, yaniv.kamay@qumranet.com
Subject: [PATCH 0/6] KVM: Add AMD SVM support
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for AMD processors with SVM (or AMD-V) 
technology.

KVM on AMD is fairly fast despite the naive mmu implementation.  It 
should also support many more guests, since the real mode implementation 
on AMD is complete.

The bulk of the work was performed by Yaniv; I ported it to the arch 
split patchset I posted yesterday.

-- 
error compiling committee.c: too many arguments to function

