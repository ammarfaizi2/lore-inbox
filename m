Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266118AbUAMWgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 17:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265965AbUAMWfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 17:35:10 -0500
Received: from feather2.animeslovenija.org ([193.77.122.70]:17555 "EHLO
	mail.animeslovenija.org") by vger.kernel.org with ESMTP
	id S265925AbUAMWd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 17:33:26 -0500
Date: Tue, 13 Jan 2004 23:33:20 +0100
From: Jure =?UTF-8?B?UGXEjWFy?= <pegasus@nerv.eu.org>
To: Scott Long <scott_long@adaptec.com>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Re: Proposed enhancements to MD
Message-Id: <20040113233320.23e4cfef.pegasus@nerv.eu.org>
In-Reply-To: <400457E3.5030602@adaptec.com>
References: <40043C75.6040100@pobox.com>
	<400457E3.5030602@adaptec.com>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004 13:41:07 -0700
Scott Long <scott_long@adaptec.com> wrote:

> A problem that we've encountered, though, is the following sequence:
> 
> 1) md is inialized during boot
> 2) drives X Y and Z are probed during boot
> 3) root fs exists on array [X Y Z], but md didn't see them show up,
>     so it didn't auto-configure the array
> 
> I'm not sure how this can be addressed by a userland daemon.  Remember
> that we are focused on providing RAID during boot; configuring a
> secondary array after boot is a much easier problem.

Looking at this chicken-and-egg problem of booting from an array from
administrator's point of view ...

What do you guys think about Intel's EFI? I think it would be the most
apropriate place to put a piece of code that would scan the disks, assemble
any arrays and present them to the OS as bootable devices ... If we're going
to get a common metadata layout, that would be even easier.

Thoughts?

-- 

Jure Pečar
