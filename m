Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262493AbVBBUOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbVBBUOw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 15:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbVBBUM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 15:12:26 -0500
Received: from scl-ims.phoenix.com ([216.148.212.222]:64541 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP id S262663AbVBBUBY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 15:01:24 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Linux hangs during IDE initialization at boot for 30 sec
Date: Wed, 2 Feb 2005 12:01:05 -0800
Message-ID: <5F106036E3D97448B673ED7AA8B2B6B301ACE83D@scl-exch2k.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux hangs during IDE initialization at boot for 30 sec
Thread-Index: AcUJYTPQUqVpLZWHRmGRHLE1sFomzAAAJ4ew
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Michael Brade" <brade@informatik.uni-muenchen.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Feb 2005 20:01:18.0663 (UTC) FILETIME=[F595A570:01C50961]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>-----Original Message-----
>From: Michael Brade [mailto:brade@informatik.uni-muenchen.de] 
>Sent: Wednesday, February 02, 2005 11:55 AM
>To: Aleksey Gorelov
>Subject: Re: Linux hangs during IDE initialization at boot for 30 sec
>
>Hi,
>
>> Since you don't care about anything except ide0 & ide1, try to add
>> the following to the kernel's command line:
>> ide2=noprobe ide3=noprobe ide4=noprobe ide5=noprobe
>Awesome! Thanks, booting is finally acceptably fast again :-) 
>Just strange 
>that it worked for the last 3 years (in fact, 7 years) with 
>just about every 
>kernel version that's out there... but I'm happy with the workaround.
>
Was it exact same hardware ?

>Cheers,
>-- 
>Michael Brade;                 KDE Developer, Student of 
>Computer Science
>  |-mail: echo brade !#|tr -d "c oh"|s\e\d 
>'s/e/\@/2;s/$/.org/;s/bra/k/2'
>  °--web: http://www.kde.org/people/michaelb.html
>
>KDE 3: The Next Generation in Desktop Experience
>
