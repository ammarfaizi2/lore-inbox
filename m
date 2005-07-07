Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVGGMxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVGGMxW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 08:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVGGMvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 08:51:32 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:26799 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S261346AbVGGMtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 08:49:45 -0400
To: ncunningham@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [0/48] Suspend2 2.1.9.8 for 2.6.12
In-Reply-To: <1120738525.4860.1433.camel@localhost>
References: <11206164393426@foobar.com> <20050706082230.GF1412@elf.ucw.cz> <20050706082230.GF1412@elf.ucw.cz> <1120696047.4860.525.camel@localhost> <E1DqV7G-0004PX-00@chiark.greenend.org.uk> <E1DqV7G-0004PX-00@chiark.greenend.org.uk> <1120738525.4860.1433.camel@localhost>
Date: Thu, 7 Jul 2005 13:49:45 +0100
Message-Id: <E1DqVp3-00064l-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@cyclades.com> wrote:
> On Thu, 2005-07-07 at 22:04, Matthew Garrett wrote:
>> Do you implement the entire swsusp userspace interface? If not, removing
>> it probably isn't a reasonable plan without fair warning.
> 
> I'm not suggesting removing the sysfs interface or replacing system to
> ram - just the suspend to disk part.

Right, so you support the resume from disk trigger in sysfs and the
/proc/acpi/sleep interface? If suspend2 is a complete dropin replacement
then I'm much happier with the idea of dropping swsusp, but I don't want
to have to tie suspend/resume scripts to kernel versions.
-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
