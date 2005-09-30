Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbVI3MUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbVI3MUI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 08:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbVI3MUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 08:20:08 -0400
Received: from fmr16.intel.com ([192.55.52.70]:11910 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030270AbVI3MUH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 08:20:07 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE:  Re: em64t speedstep technology not supported in kernel yet?
Date: Fri, 30 Sep 2005 05:20:03 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6005DECA92@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: em64t speedstep technology not supported in kernel yet?
Thread-Index: AcXFKQkW1FUP5pgaRNacj9L4u1jOdAAj2eUg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Wes Felter" <wesley@felter.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Sep 2005 12:20:04.0699 (UTC) FILETIME=[49C1DAB0:01C5C5B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Wes Felter
>Sent: Thursday, September 29, 2005 11:58 AM
>To: linux-kernel@vger.kernel.org
>Subject: Re: em64t speedstep technology not supported in kernel yet?
>
>Richard Wohlstadter wrote:
>> Hello all,
>> 
>> We recently had Intel give our company a roadmap 
>presentation where they 
>> told us that their enhanced speedstep technology was 
>supported by linux 
>> kernels 2.6.9+.  I have since tried to get cpufreq speedstep 
>driver to 
>> work with no luck on our em64t Xeon 3.6g processors.  Intel 
>even has a 
>> webpage describing the technology and how to get it working at url: 
>> http://www.intel.com/cd/ids/developer/asmo-na/eng/195910.htm?prn=Y
>
>I think this is a BIOS problem; the BIOS needs to provide the proper 
>ACPI frequency/voltage tables for cpufreq to use. You might want to 
>harass your system/motherboard vendor.
>
>Alternately maybe you can find someone who can give you the 
>secret table 
>and then you can just hardcode it into the driver.
>

Yes. Make sure speedstep is  supported and enabled in BIOS. Typically,
there will be a BIOS config option under CPU section, called Speedstep, 
Enhanced Speedstep or EIST or something like that. 

Which kernels did you try? Also, if you can send the acpidump output 
from pmtools here 
http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
We can see whether BIOS is indeed supporting speedstep or not.

Thanks,
Venki
