Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWJMOTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWJMOTV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 10:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWJMOTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 10:19:21 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:24198 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750855AbWJMOTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 10:19:20 -0400
Date: Fri, 13 Oct 2006 10:18:45 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Steven Truong <midair77@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kdump/kexec/crash on vmcore file
Message-ID: <20061013141845.GB27375@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <28bb77d30610121450n6cfd9c6ejd6b0370d2400a378@mail.gmail.com> <28bb77d30610121456t7f3738c6jf7be44ede5e59b4e@mail.gmail.com> <28bb77d30610121501n4c8e28b6r9c86235f7c7b4e83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28bb77d30610121501n4c8e28b6r9c86235f7c7b4e83@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 03:01:06PM -0700, Steven Truong wrote:
> I also tried to gdb the vmcore file but I got errors too.
> gdb vmcore.test
> GNU gdb Red Hat Linux (6.3.0.0-1.96rh)
> 

You should be running gdb as

gdb vmlinux vmcore

vmlinux is first kernel's executable and should be compiled with
CONFIG_DEBUG_INFO.

Thanks
Vivek
