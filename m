Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbUCVMQH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 07:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbUCVMQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 07:16:07 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:27403 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261906AbUCVMQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 07:16:05 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: do we want to kill VM_RESERVED or not? [was Re: 2.6.5-rc1-aa3]
Date: Mon, 22 Mar 2004 13:10:38 +0100
User-Agent: KMail/1.6.1
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <20040320210306.GA11680@dualathlon.random> <200403212042.18092@WOLK> <20040322001023.GD3649@dualathlon.random>
In-Reply-To: <20040322001023.GD3649@dualathlon.random>
X-Operating-System: Linux 2.6.4-wolk2.1 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200403221310.38481@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 March 2004 01:10, Andrea Arcangeli wrote:

Hi Andrea,

> You're welcome, you should also thank Dave and Hugh even before you
> thank me ;), since they solved many of the problems to make this
> possible years ago even before I started working on the objrmap myself.

Okay :)

> it's not an oops report, it's a warning only and it should not affect
> functionality in any way (vmware should still work). The vmware fix will
> shutdown the warning so you won't be annoyed anymore by it ;)

well, ok. The first two things are warnings, the last is a kernel bug.

And VMware won't work at all. Booting a VMware Image triggers the 2 warnings 
and the kernel BUG and the screen stays black in VMware.

cioa, Marc
