Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266100AbUFJCGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266100AbUFJCGv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 22:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266103AbUFJCGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 22:06:51 -0400
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:32173 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S266100AbUFJCGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 22:06:50 -0400
Message-ID: <40C7C310.1010009@earthlink.net>
Date: Wed, 09 Jun 2004 19:10:24 -0700
From: Phil Brunner <pbrunner1@earthlink.net>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc3-mm1
References: <20040609015001.31d249ca.akpm@osdl.org>
In-Reply-To: <20040609015001.31d249ca.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc3/2.6.7-rc3-mm1/
> 
Could not compile with CONFIG_X86_IO_APIC=y. Function call to 
(undefined) mp_register_gsi in arch/i386/kernel/acpi/boot.c is the problem.

Code in arch/i386/kernel/mpparse.c may be the appropriate function 
definition (?).

- Phil
