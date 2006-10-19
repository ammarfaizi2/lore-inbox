Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946585AbWJSW0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946585AbWJSW0A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 18:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946587AbWJSW0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 18:26:00 -0400
Received: from bizon.gios.gov.pl ([212.244.124.8]:45956 "EHLO
	bizon.gios.gov.pl") by vger.kernel.org with ESMTP id S1946585AbWJSWZ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 18:25:59 -0400
Date: Fri, 20 Oct 2006 00:25:48 +0200 (CEST)
From: Krzysztof Oledzki <olel@ans.pl>
X-X-Sender: olel@bizon.gios.gov.pl
To: Wes Felter <wesley@felter.org>
cc: linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
Subject: Re: 3.2GHz cpus with cpufreq become 2.8GHz
In-Reply-To: <4537A582.4020406@felter.org>
Message-ID: <Pine.LNX.4.64.0610200022320.30089@bizon.gios.gov.pl>
References: <Pine.LNX.4.64.0610182133130.29935@bizon.gios.gov.pl>
 <4537A582.4020406@felter.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-1520145228-1161296748=:30089"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-1520145228-1161296748=:30089
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Thu, 19 Oct 2006, Wes Felter wrote:

> Krzysztof Oledzki wrote:
>> Hello,
>>=20
>> I have just noticed that enabling cpufreq on my Dell PowerEdge 1425SC=20
>> changes my secondary cpu clock to 2.8GHz.
>
> [snip]
>
>> # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
>> p4-clockmod
>
> You shouldn't be using this driver. Use speedstep-centrino or

Hm... speedstep-centrino on Xeon? AFAIK speedstep-centrino requires "est"=
=20
and /proc/cpuinfo does not mention this flag:
  fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 c=
lflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc pni monit=
or ds_cpl cid cx16 xtpr

> acpi-cpufrreq.

I will check this, thank you. BTW: what wrong is with p4-clockmod? I was=20
not able to find any information that it is broken and should not be=20
used?

Best regards,


 =09=09=09=09Krzysztof Ol=EAdzki
---187430788-1520145228-1161296748=:30089--
