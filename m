Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313773AbSDHVzH>; Mon, 8 Apr 2002 17:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313774AbSDHVzF>; Mon, 8 Apr 2002 17:55:05 -0400
Received: from mailout.zma.compaq.com ([161.114.64.104]:64785 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S313773AbSDHVzA> convert rfc822-to-8bit; Mon, 8 Apr 2002 17:55:00 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: system call for finding the number of cpus??
Date: Mon, 8 Apr 2002 17:54:58 -0400
Message-ID: <6B003D25ADBDE347B5542AFE6A55B42E01A44520@tayexc13.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: system call for finding the number of cpus??
Thread-Index: AcHfR1+v4jJ+uly7R4WUvdqu8Qc6UwAAA41w
From: "Kuppuswamy, Priyadarshini" <Priyadarshini.Kuppuswamy@compaq.com>
To: "Davide Libenzi" <davidel@xmailserver.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Apr 2002 21:54:58.0266 (UTC) FILETIME=[067E3BA0:01C1DF48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think that (sysconf(_SC_NPROCESSORS_CONF)) command works on linux. It works on Unix. I tried that. It returns 1 when there are 4 processors on linux.


-----Original Message-----
From: Davide Libenzi [mailto:davidel@xmailserver.org]
Sent: Monday, April 08, 2002 5:57 PM
To: Kuppuswamy, Priyadarshini
Cc: linux-kernel@vger.kernel.org
Subject: Re: system call for finding the number of cpus??


On Mon, 8 Apr 2002, Kuppuswamy, Priyadarshini wrote:

> Hi!
>   I have a script that is using the /cpu/procinfo file to determine the
> number of cpus present in the system. But I would like to implement it
> using a system call rather than use the environment variables?? I
> couldn't find a system call for linux that would give me the result.
> Could anyone please let me know if there is one for redhat linux??

sysconf(_SC_NPROCESSORS_CONF);




- Davide


