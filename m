Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270499AbTGXGSi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 02:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270501AbTGXGSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 02:18:38 -0400
Received: from sinma-gmbh.17.mind.de ([212.21.92.17]:52229 "EHLO gw.enyo.de")
	by vger.kernel.org with ESMTP id S270499AbTGXGSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 02:18:37 -0400
To: Dominik Brugger <dominik83@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test1] ACPI slowdown
References: <878yqpptez.fsf@deneb.enyo.de>
	<20030723114421.34eb7149.dominik83@gmx.net>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: Dominik Brugger <dominik83@gmx.net>,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Jul 2003 08:33:42 +0200
In-Reply-To: <20030723114421.34eb7149.dominik83@gmx.net> (Dominik Brugger's
 message of "Wed, 23 Jul 2003 11:44:21 +0200")
Message-ID: <87el0gv3g9.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brugger <dominik83@gmx.net> writes:

> On Wed, 23 Jul 2003 09:57:08 +0200
> Florian Weimer <fw@deneb.enyo.de> wrote:
>
>> If I enable ACPI on my box (Athlon XP at 1.6 GHz, Epox EP-8KHa+
>> mainboard), it becomes very slow (so slow that it's unusable).
>> 
>> Is this a known issue?  Maybe the thermal limits are misconfigured,
>> and the CPU clock is throttled unnecessarily (if something like this
>> is supported at all).
>
> I use the same board with ACPI enabled, no slow down.

Could you post the output of "tail /proc/acpi/thermal_zone/THRM/*"?
Thanks.
