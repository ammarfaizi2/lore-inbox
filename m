Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758081AbWK0MKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758081AbWK0MKs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758082AbWK0MKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:10:48 -0500
Received: from il.qumranet.com ([62.219.232.206]:30911 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758081AbWK0MKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:10:47 -0500
Message-ID: <456AD5C6.1090406@qumranet.com>
Date: Mon, 27 Nov 2006 14:10:46 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: kvm-devel@lists.sourceforge.net
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/38] KVM: Decouple Intel VT implementation from base kvm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset prepares kvm for multiple architecture implementations.  
The kvm.ko module is split into kvm.ko and kvm-intel.ko, and a function 
vector is used to dispatch arch specific operations to the arch module.


-- 
error compiling committee.c: too many arguments to function

