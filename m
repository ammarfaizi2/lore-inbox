Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbVDFBcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbVDFBcj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 21:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVDFBcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 21:32:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:31184 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262065AbVDFBcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 21:32:25 -0400
Date: Tue, 5 Apr 2005 18:31:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Norbert Preining <preining@logic.at>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: It's getting worse: 2.6.12-rc2-mm1 and suspend2ram
Message-Id: <20050405183144.50ed3a9c.akpm@osdl.org>
In-Reply-To: <20050405221903.GA21196@gamma.logic.tuwien.ac.at>
References: <20050405181628.GB6879@gamma.logic.tuwien.ac.at>
	<20050405204107.GD1380@elf.ucw.cz>
	<20050405210041.GA16263@gamma.logic.tuwien.ac.at>
	<20050405211340.GF1380@elf.ucw.cz>
	<20050405221903.GA21196@gamma.logic.tuwien.ac.at>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining <preining@logic.at> wrote:
>
> On Die, 05 Apr 2005, Pavel Machek wrote:
> > Well, I do not have working suspend-to-RAM setup close to me... Could
> > you try 2.6.12-rc1 to see if reboot problem is -mm specific or not?
> 
> 2.6.12-rc2 suspends and resumes with the very same config file (well,
> after running make oldconfig) without any problem.
> 
> So there is a change in -mm1 which triggers this. Should I start with
> backing out bk-acpi? or anything else?

bk-acpi would be a good choice.  It might be easier to start with
2.6.12-rc2 and add stuff, see when it breaks.

bk-acpi and bk-driver-core would be prime suspects.

Thanks for the help on this.
