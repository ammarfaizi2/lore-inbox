Return-Path: <linux-kernel-owner+w=401wt.eu-S1751327AbWLLN4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWLLN4A (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 08:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWLLN4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 08:56:00 -0500
Received: from il.qumranet.com ([62.219.232.206]:35409 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327AbWLLNz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 08:55:59 -0500
Message-ID: <457EB4ED.6020407@qumranet.com>
Date: Tue, 12 Dec 2006 15:55:57 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: kvm-devel@lists.sourceforge.net
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 0/3] KVM: Some more fixes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset prevents people from shooting themselves in the foot by 
loading the wrong module, allows macbook owners to shoot their feet by 
making the module work, and removes some random error messages on 32-bit 
hosts.

-- 
error compiling committee.c: too many arguments to function

