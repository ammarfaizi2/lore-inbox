Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVGGKf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVGGKf7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 06:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVGGKf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 06:35:58 -0400
Received: from [202.125.86.130] ([202.125.86.130]:62196 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S261278AbVGGKfl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 06:35:41 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Fedora core 3 Version magic error..
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Thu, 7 Jul 2005 16:13:56 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB3481161079C@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fedora core 3 Version magic error..
Thread-Index: AcWCxJd5/k50SWzUQxSnwkhObVlXoAAGDHbg
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: "Sam Ravnborg" <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear sam,
I was using an automated script to build the module sources.
I failed noticing the module build failing due to some modifications.
And the script was using the old version of object file to build the
rpm.
That's the problem. It is rectified now.

Thanks for the response.

Regards,
Mukund jampala


>-----Original Message-----
>From: Sam Ravnborg [mailto:sam@ravnborg.org]
>Sent: Thursday, July 07, 2005 2:47 PM
>To: Mukund JB.
>Cc: linux-kernel@vger.kernel.org
>Subject: Re: Fedora core 3 Version magic error..
>
>On Thu, Jul 07, 2005 at 12:12:12PM +0530, Mukund JB. wrote:
>> Dear all,
>> ?
>> I have a problem loading the rpm build locally on Fedora core 3,
linux
>kernel 2.6.10.
>> ?
>> After building the rpm file from the available sources on the Linux
>kernel 2.6.10 which was D/W from kernel.org and build, I am unable to
load
>it.
>> ?
>> It results in the following errors:-
>> tifm: version magic '2.6.10 686 REGPARM gcc-3.3' should be '2.6.10
>REGPARM gcc-3.4'
>> ?
>Looks like you did not compile the tifm module with latest compiler.
>
>	Sam
