Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbUDDWAn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 18:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262852AbUDDWAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 18:00:43 -0400
Received: from paja.kn.vutbr.cz ([147.229.191.135]:7689 "EHLO paja.kn.vutbr.cz")
	by vger.kernel.org with ESMTP id S262860AbUDDWAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 18:00:41 -0400
Message-ID: <40708569.7060403@stud.feec.vutbr.cz>
Date: Mon, 05 Apr 2004 00:00:09 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olivier Bornet <Olivier.Bornet@puck.ch>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5, ACPI, suspend and ThinkPad R40
References: <20040404173646.GA15635@puck.ch>
In-Reply-To: <20040404173646.GA15635@puck.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Bornet wrote:
> Hello,
> 
> I have an IBM ThinkPad R40, with kernel 2.6.5 and ACPI enabled. The
> system is a GNU/Debian testing up-to-date, with acpid debian package
> 1.0.3-2.
> 

I have an R40 too (model 2681-HSG).

> I can suspend with Fn-F4, thanks to a acpi config doing:
> 
>     echo 3 > /proc/acpi/sleep
> 
> The laptop goes to sleep as execpted: all the lights goes off, and the
> light with the moon goes on. All is OK until this. :-)
> 
> The problem is that I can't resume it. I have found no way. Pressing Fn
> don't work. The power button don't work. Closing and opening the display
> don't work. The only way to re-start the computer is to remove the
> battery. Of course, this cause a reboot.
>

I had exactly the same problem.

> Has anyone some suggestion for me ?
> 

Yes, see:
   http://bugzilla.kernel.org/show_bug.cgi?id=1415
There is a patch which worked for me.

> Thanks in advance.
> 
> 		Olivier

Michal Schmidt
