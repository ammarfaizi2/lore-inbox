Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275934AbSIUVs5>; Sat, 21 Sep 2002 17:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275943AbSIUVs5>; Sat, 21 Sep 2002 17:48:57 -0400
Received: from duck.doc.ic.ac.uk ([146.169.1.46]:53008 "EHLO duck.doc.ic.ac.uk")
	by vger.kernel.org with ESMTP id <S275934AbSIUVs4>;
	Sat, 21 Sep 2002 17:48:56 -0400
Date: Sat, 21 Sep 2002 22:54:04 +0100 (BST)
From: Guido Arenstedt <ga200@doc.ic.ac.uk>
To: James Cleverdon <jamesclv@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Hyperthreading in -ac series
In-Reply-To: <200209201547.59508.jamesclv@us.ibm.com>
Message-ID: <Pine.LNX.4.42.0209212250550.2649-100000@moa.doc.ic.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2002, James Cleverdon wrote:

>On Friday 20 September 2002 03:36 pm, Guido Arenstedt wrote:
>> Hyperthreading does not seem to work in the -ac series
>> it works fine with a stock 2.4.19 kernel
>>
>> during bootup i only get the message:
>> WARNING: No sibling found for CPU 0.
>> WARNING: No sibling found for CPU 1.
>>
>> or is this done on purpose?
>
>The latter.  Hyperthreading _is_ working in the kernel, but it is not finding
>"sibling" CPUs to match the real ones.  (Or, as we prefer to call them,
>DiVitos to match the Schwartzenegers.  ;^)
>
>Check your BIOS.  Some turn off hyperthreading by default.  (Notably, IBM's
>x440....)

no hyperthreading is on in the bios
my problem is that hyperthreading does not work with an -ac kernel
(i have check 2.4.19-ac4 and 2.4.20-pre5-ac4)
whereas a stock kernel is working fine.


