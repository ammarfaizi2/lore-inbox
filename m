Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbVCNVch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVCNVch (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 16:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVCNVcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 16:32:36 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:55480 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261405AbVCNVbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 16:31:51 -0500
Date: Mon, 14 Mar 2005 13:31:05 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kai@germaschewski.name
Subject: Re: 2.6.11-bk10 build problems
Message-ID: <2480000.1110835865@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > On popular request 'make install' no longer try to update vmlinux.
>> > This is to avoid errornous recompilation when installing the kernel
>> > as root especially when fetching kernel via nfs where path may have
>> > changed.
>> 
>> That's frigging annoying. It's worked that way for ages, and all our
>> scripts assume it works. 
> 
> The reason to put it in -mm is to check how things are used.

Heh, good plan - except it got sent upstream rather quickly ;-)

> I will change it back and add an:
> make kernel_install
> 
> kernel_install is then analogous to modules_install

Splendid. thanks very much. Apologies for being in a pissy mood - is one
of those days where NOTHING works ;-)

M.

