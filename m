Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316047AbSGSHKt>; Fri, 19 Jul 2002 03:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSGSHKt>; Fri, 19 Jul 2002 03:10:49 -0400
Received: from ns.suse.de ([213.95.15.193]:19729 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316047AbSGSHKs>;
	Fri, 19 Jul 2002 03:10:48 -0400
To: Andi Kleen <ak@suse.de>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: Second x86-64 kernel snapshot based on 2.4.19rc1 released
References: <20020716220302.A5400@wotan.suse.de>
	<3D347F9B.58740355@nortelnetworks.com>
	<20020716222640.A10397@wotan.suse.de>
From: Andreas Jaeger <aj@suse.de>
Date: Fri, 19 Jul 2002 09:13:47 +0200
In-Reply-To: <20020716222640.A10397@wotan.suse.de> (Andi Kleen's message of
 "Tue, 16 Jul 2002 22:26:40 +0200")
Message-ID: <ho4rew5gwk.fsf@gee.suse.de>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Tue, Jul 16, 2002 at 04:18:35PM -0400, Chris Friesen wrote:
>> Andi Kleen wrote:
>> 
>> > - vsyscalls are currently disabled because they trigger too many linker bugs together
>> > with HPET timers. The vsyscall pages just call normal syscalls.
>> 
>> I assume that the linker is going to get fixed before general x86-64 release so
>> these can be used together?
>
> Yes, the problem is being worked on.

It looks currently like a kernel bug - the linker is fine.  We're
currently working on a proper fix for this and I hope that Andi's next
kernel will work correctly.

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
