Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758086AbWK0MNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758086AbWK0MNK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758087AbWK0MNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:13:09 -0500
Received: from il.qumranet.com ([62.219.232.206]:8146 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758088AbWK0MNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:13:06 -0500
Message-ID: <456AD650.4020300@qumranet.com>
Date: Mon, 27 Nov 2006 14:13:04 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: kvm-devel@lists.sourceforge.net
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/38] KVM: Decouple Intel VT implementation from base
 kvm
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
> This patchset prepares kvm for multiple architecture implementations.  
> The kvm.ko module is split into kvm.ko and kvm-intel.ko, and a 
> function vector is used to dispatch arch specific operations to the 
> arch module.
>

It should be noted that the patchset is bisect friendly (and will even 
boot a guest for you at any point in the set).

-- 
error compiling committee.c: too many arguments to function

