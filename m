Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbUCEEDQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 23:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbUCEEDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 23:03:16 -0500
Received: from [63.161.72.3] ([63.161.72.3]:64666 "EHLO
	mail.standardbeverage.com") by vger.kernel.org with ESMTP
	id S262189AbUCEEDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 23:03:14 -0500
Message-ID: <a2dddb49576d8789a2f7092911006002@stdbev.com>
Date: Thu,  4 Mar 2004 22:08:09 -0600
From: "Jason Munro" <jason@stdbev.com>
Subject: Re: ACPI battery info failure after some period of time, 2.6.3-x and up
To: linux-kernel@vger.kernel.org
Reply-to: <jason@stdbev.com>
In-Reply-To: <4047756D.2050402@blue-labs.org>
References: <4047756D.2050402@blue-labs.org>
X-Mailer: Hastymail 1.0-rc1-CVS
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:29 pm Mar 4 David Ford <david+challenge-response@blue-labs.org> wrote:
> powerix root # cat /proc/acpi/battery/BAT0/state
> present:                 yes
> ERROR: Unable to read battery status
>
> powerix root # dmesg -c
>     ACPI-0279: *** Error: Looking up [BST0] in namespace,
> AE_ALREADY_EXISTS     ACPI-1120: *** Error: Method execution failed
> [\_SB_.BAT0._BST] (Node e7bd7680), AE_ALREADY_EXISTS
>
> powerix root # uname -r
> 2.6.4-rc1
>
> This has been going on since about 2.6.3-rc something.  Some while
> after reading the /proc files, the ability to read the battery
> information gets munged.

Same here on a Toshiba 1410-s173 noteboook:

[logger] ACPI group battery / action battery is not defined
[kernel] ACPI-0279: *** Error: Looking up [BUFF] in namespace, 
         AE_ALREADY_EXISTS

I don't think it's happened in less than 24 hours of uptime, during which
everything is good. I have been using suspend to ram daily if that matters
(echo 3 > /proc/acpi/sleep).

Linux version 2.6.3-wolk1.0 (root@jackass) (gcc version 3.3.3 20040217
(Gentoo Linux 3.3.3, propolice-3.3-7)) #1 Thu Feb 26 16:18:24 CST 2004

\__ Jason Munro
 \__ jason@stdbev.com
  \__ http://hastymail.sourceforge.net/


