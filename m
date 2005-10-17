Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbVJQN5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVJQN5u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 09:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbVJQN5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 09:57:50 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:40144 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751325AbVJQN5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 09:57:49 -0400
In-Reply-To: <12922.194.237.142.21.1127462553.squirrel@194.237.142.21>
References: <CE56193B-A4BB-4557-87C0-BFCC6B9E7E5B@freescale.com> <20050922214940.5ab30894.rdunlap@xenotime.net> <669340F6-17D1-487D-A055-374077E96500@freescale.com> <6017D66D-E5E5-4C0E-BE65-952BEA405F0C@freescale.com> <12922.194.237.142.21.1127462553.squirrel@194.237.142.21>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0B3F35F7-9558-4314-A330-594A9E5A539D@freescale.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: kernel buildsystem error/warning?
Date: Mon, 17 Oct 2005 08:58:09 -0500
To: Sam Ravnborg <sam@ravnborg.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

Did you ever get around to this.  It appears to still be "broken".

- kumar

On Sep 23, 2005, at 3:02 AM, Sam Ravnborg wrote:

>>>
>>>
>> After some more debug it appears that define rule_vmlinux__ is what's
>> causing this and in my .config CONFIG_KALLSYMS is not defined.
>>
>> Not sure if that will help.  If I enable CONFIG_KALLSYMS the "error"
>> goes away (which makes sense based on the rule_vmlinux__) define.
>>
>
> Good info - thanks.
> I will fix it in the weekend.
>
>    Sam
>

