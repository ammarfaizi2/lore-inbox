Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSDPKmD>; Tue, 16 Apr 2002 06:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312208AbSDPKmC>; Tue, 16 Apr 2002 06:42:02 -0400
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:49422 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S311898AbSDPKmC> convert rfc822-to-8bit; Tue, 16 Apr 2002 06:42:02 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Subject: RE: Why HZ on i386 is 100 ?
Date: Tue, 16 Apr 2002 12:41:43 +0200
Message-ID: <11EB52F86530894F98FFB1E21F9972547EF917@aeoexc01.emea.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Why HZ on i386 is 100 ?
Thread-Index: AcHlLzo8zaYUgebzToaIW702sU1LNgAA9Tbg
From: "Cabaniols, Sebastien" <Sebastien.Cabaniols@Compaq.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Apr 2002 10:41:44.0421 (UTC) FILETIME=[4D30A150:01C1E533]
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>> -----Original Message-----
>> From: Olaf Fraczyk [mailto:olaf@navi.pl]
>> Sent: mardi 16 avril 2002 12:02
>> To: Liam Girdwood
>> Cc: BALBIR SINGH; William Lee Irwin III; linux-kernel@vger.kernel.org
>> Subject: Re: Why HZ on i386 is 100 ?
>> 
>> 
>> On 2002.04.16 12:29 Liam Girdwood wrote:
>> > On Tue, 2002-04-16 at 09:18, BALBIR SINGH wrote:
>> > > I remember seeing somewhere unix system VII used to have 
>> HZ set to
>> > 60
>> > > for the machines built in the 70's. I wonder if todays 
>> pentium iiis
>> > and ivs
>> > > should still use HZ of 100, though their internal clock 
>> is in GHz.
>> > >
>> > > I think somethings in the kernel may be tuned for the 
>> value of HZ,
>> > these
>> > > things would be arch specific.
>> > >
>> > > Increasing the HZ on your system should change the scheduling
>> > behaviour,
>> > > it could lead to more aggresive scheduling and could affect the
>> > > behaviour of the VM subsystem if scheduling happens more 
>> frequently.
>> > I am
>> > > just guessing, I do not know.
>> > >
>> > 
>> > I remember reading that a higher HZ value will make your 
>> machine more
>> > responsive, but will also mean that each running process 
>> will have a
>> > smaller CPU time slice and that the kernel will spend more CPU time
>> > scheduling at the expense of processes.
>> > 
>> Has anyone measured this?
>> This shouldn't be a big problem, because some architectures 
>> use value 
>> 1024, eg. Alpha, ia-64.
>> And todays Intel/AMD 32-bit processors are as fast as Alpha was 1-2 
>> years ago.

Anyone knows if this would be interesting to decrease this value
for computationnal farms and CPU/memory bound tasks ?

