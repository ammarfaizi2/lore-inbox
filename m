Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266820AbUJRRQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266820AbUJRRQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 13:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUJRRQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 13:16:57 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7040 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266820AbUJRRQx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 13:16:53 -0400
Date: Mon, 18 Oct 2004 13:14:32 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Greg KH <greg@kroah.com>
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Lee Revell <rlrevell@joe-job.com>,
       David Woodhouse <dwmw2@infradead.org>, Josh Boyer <jdub@us.ibm.com>,
       gene.heskett@verizon.net, Linux kernel <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       David Howells <dhowells@redhat.com>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>
Subject: Re: Fw: signed kernel modules?
In-Reply-To: <20041018163346.GB18169@kroah.com>
Message-ID: <Pine.LNX.4.61.0410181306030.4196@chaos.analogic.com>
References: <200410151153.08527.gene.heskett@verizon.net>
 <1097857049.29988.29.camel@weaponx.rchland.ibm.com>
 <Pine.LNX.4.61.0410151237360.6239@chaos.analogic.com>
 <1097860121.13633.358.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.61.0410151319460.6877@chaos.analogic.com>
 <1097873791.5119.10.camel@krustophenia.net> <20041015211809.GA27783@kroah.com>
 <4170426E.5070108@nortelnetworks.com> <Pine.LNX.4.61.0410151744220.3651@chaos.analogic.com>
 <Pine.LNX.4.61.0410180845040.3512@chaos.analogic.com> <20041018163346.GB18169@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004, Greg KH wrote:

> On Mon, Oct 18, 2004 at 08:53:46AM -0400, Richard B. Johnson wrote:
>> +/*
>> + *  List of acceptable module-license strings.
>> + */
>> +static const char *licok[]= {
>> +    "GPL",
>> +    "GPL v2",
>> +    "CPL and additional rights",
>
> The CPL is very different from the GPL and the two are not compatible,
> so this isn't an acceptable patch.
>
> thanks,
>
> greg k-h

Right and it wasn't that way when the patch was generated and
C and G are so far apart it couldn't be a typo so I don't
know why it shows up that way.


Script started on Mon 18 Oct 2004 01:10:46 PM EDT
# grep GPL sent-mail
> MODULE_LICENSE("GPL");
> If you can reproduce the same problem with some GPL version of
iriUIyCrAzt70kZPD/T3qtlHKJ+UwCGrMj1c6GPLs/J0VFvR2NEqY369qAC7
>>  *   lawyer, and require that a GPL License exist for every kernel
> GPL licensing. It provides help in understanding what symbols are
> source or GPL information.
a bug report. This whole GPL thing has taken a real stupid
> MODULE_LICENSE("GPL");
iriUIyCrAzt70kZPD/T3qtlHKJ+UwCGrMj1c6GPLs/J0VFvR2NEqY369qAC7
+    "GPL",
+    "GPL v2",
+    "GPL and additional rights",
+    "Dual BSD/GPL",
+    "Dual MPL/GPL",
-	return (strcmp(license, "GPL") == 0
-		|| strcmp(license, "GPL v2") == 0
-		|| strcmp(license, "GPL and additional rights") == 0
-		|| strcmp(license, "Dual BSD/GPL") == 0
-		|| strcmp(license, "Dual MPL/GPL") == 0);
+    "GPL",
+    "GPL v2",
+    "GPL and additional rights",
+    "Dual BSD/GPL",
+    "Dual MPL/GPL",
-	return (strcmp(license, "GPL") == 0
-		|| strcmp(license, "GPL v2") == 0
-		|| strcmp(license, "GPL and additional rights") == 0
-		|| strcmp(license, "Dual BSD/GPL") == 0
-		|| strcmp(license, "Dual MPL/GPL") == 0);
>> +    "GPL",
>> +    "GPL v2",
>        ^^^  GPL
# bye
bash: bye: command not found
# exit

Script done on Mon 18 Oct 2004 01:11:05 PM EDT


Cheers,
Dick Johnson
Penguin : Linux version 2.6.8 on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

