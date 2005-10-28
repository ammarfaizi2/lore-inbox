Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbVJ1QCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbVJ1QCL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 12:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbVJ1QCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 12:02:11 -0400
Received: from teetot.devrandom.net ([66.35.250.243]:6368 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1030229AbVJ1QCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 12:02:09 -0400
Date: Fri, 28 Oct 2005 09:04:03 -0700
From: thockin@hockin.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Vladimir Lazarenko <vlad@lazarenko.net>, linux-kernel@vger.kernel.org
Subject: Re: AMD Athlon64 X2 Dual-core and 4GB
Message-ID: <20051028160403.GA26286@hockin.org>
References: <4361408B.60903@lazarenko.net> <m1irvhbqvo.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1irvhbqvo.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 09:30:51AM -0600, Eric W. Biederman wrote:
> > Thus, the question - would I be able to use whole 4G RAM with dual-core amd and
> > kernel with SMP compiled for i686?

Why would you use a dual core AMD in 32 bit mode?  Just build an x86_64
kernel.

If you want to use 4GB in 32 bit mode, you *need* remapping (or you lose
part of your memory).  Remapping means you have MORE than 4 GB of physical
address, which means you need PAE to use it at all.
