Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWH0RUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWH0RUn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 13:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWH0RUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 13:20:43 -0400
Received: from gw.goop.org ([64.81.55.164]:52661 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932191AbWH0RUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 13:20:42 -0400
Message-ID: <44F1D464.5020304@goop.org>
Date: Sun, 27 Aug 2006 10:20:36 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH RFC 3/6] Use %gs as the PDA base-segment in the kernel.
References: <20060827084417.918992193@goop.org> <20060827084451.492329798@goop.org> <200608271757.18621.ak@suse.de>
In-Reply-To: <200608271757.18621.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> +1:	movw GS(%esp), %gs
>>     
>
> movl is recommended in 32bit mode
>   

arch/i386/kernel/entry.S: Assembler messages:
arch/i386/kernel/entry.S:334: Error: suffix or operands invalid for `mov'

    J
