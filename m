Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbVHKUWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbVHKUWf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 16:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbVHKUWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 16:22:35 -0400
Received: from smtp105.rog.mail.re2.yahoo.com ([206.190.36.83]:52306 "HELO
	smtp105.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932431AbVHKUWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 16:22:34 -0400
Message-ID: <42FBB37E.6070607@masoud.ir>
Date: Thu, 11 Aug 2005 16:22:22 -0400
From: Masoud Sharbiani <masouds@masoud.ir>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.3) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: System shutdown with during reboot with 2.6.13-pre6
References: <42FB89D1.1060007@masoud.ir> <42FBA220.8020508@gmail.com>
In-Reply-To: <42FBA220.8020508@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Adding reboot=w causes system to reboot properly.
Is this a known issue with 2.6.latest ACPI or is it that my mainboard is 
broken?
cheers,
Masoud

Jiri Slaby wrote:

> Masoud Sharbiani napsal(a):
>
>> Hello,
>> Whenever I reboot my Linux machine it turns itself off in the end, 
>> unless I add the 'acpi=off' to the end of kernel command line on boot.
>> Apparently, it happens after unmounting filesystems as it doesn't do 
>> fsck after next power-up.
>> ----
>> Any ideas?
>
>
> Try to change reboot behavior to warm, see 
> Documentation/kernel-parametres.txt, reboot.
>


