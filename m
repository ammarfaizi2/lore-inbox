Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752387AbWKLIWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbWKLIWa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 03:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754102AbWKLIWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 03:22:30 -0500
Received: from il.qumranet.com ([62.219.232.206]:937 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1752387AbWKLIW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 03:22:29 -0500
Message-ID: <4556D9C0.3050103@qumranet.com>
Date: Sun, 12 Nov 2006 10:22:24 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Bernhard Rosenkraenzer <bero@arklinux.org>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.19-rc5-mm1 fails to compile with gcc 4.2
References: <200611112334.28889.bero@arklinux.org>
In-Reply-To: <200611112334.28889.bero@arklinux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer wrote:
> drivers/kvm/kvm_main.c: In function 'kvm_dev_ioctl_run':
> drivers/kvm/kvm_main.c:153: error: 'asm' operand has impossible constraints
> drivers/kvm/kvm_main.c:158: error: 'asm' operand has impossible constraints
>   

Smells like a gcc regression.  Can you send .config?

Or better yet, preprocessed source and full gcc command line (as seen on 
'make V=1').

-- 
error compiling committee.c: too many arguments to function

