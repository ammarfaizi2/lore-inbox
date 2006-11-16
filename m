Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162067AbWKPR7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162067AbWKPR7t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 12:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162068AbWKPR7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 12:59:49 -0500
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:14089 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1162067AbWKPR7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 12:59:49 -0500
Message-ID: <455CA70C.9060307@qumranet.com>
Date: Thu, 16 Nov 2006 19:59:40 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: kvm-devel@lists.sourceforge.net
CC: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Uri Lublin <uril@qumranet.com>
Subject: [PATCH 0/3] KVM: Save/resume support
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Nov 2006 17:59:47.0724 (UTC) FILETIME=[012DA4C0:01C709A9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchset adds the missing bits that allow kvm virtual
machines to be suspended and resumed, with appropriate
userspace support.

The changes are:
 - expose the pending interrupt bitmap to userspace
 - tsc save/restore
 - msr save/restore

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

