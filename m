Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTIPNOq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 09:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbTIPNOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 09:14:46 -0400
Received: from maverick.eskuel.net ([81.56.212.215]:22752 "EHLO
	maverick.eskuel.net") by vger.kernel.org with ESMTP id S261827AbTIPNOo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 09:14:44 -0400
Message-ID: <33165.213.193.3.110.1063718083.squirrel@webmail.eskuel.net>
In-Reply-To: <20030916114822.GB602@elf.ucw.cz>
References: <3F660BF7.6060106@eskuel.net> <20030916114822.GB602@elf.ucw.cz>
Date: Tue, 16 Sep 2003 15:14:43 +0200 (CEST)
Subject: Re: Nearly succes with suspend to disk in -test5-mm2
From: "Mathieu LESNIAK" <maverick@eskuel.net>
To: "Pavel Machek" <pavel@suse.cz>
Cc: "Mathieu LESNIAK" <maverick@eskuel.net>,
       "LKML " <linux-kernel@vger.kernel.org>, mochel@osdl.org
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi!
>
>> I've tested the last kernel of -mm series, -test5-mm2. One of the
>> important feature to me is the suspend to disk, and it's one of the
>> first kernel that suspend fine on my laptop. I'm now able to do a
>> suspend / resume cycle with nearly no problem :)
>> However, I saw some oops while resuming. Nothing critical, but if it an
>> help debugging ...
>>
>> See the attached file for the syslog part showing suspend / resume with
>> the oops.
>>
>> I can give more details on my setup if you want.
>
> cat you try with echo 4 > /proc/acpi/sleep?
> 										> Pavel

It does nothing. The only visible action is when I do : echo -n disk >
/sys/power/state



Mathieu LESNIAK
