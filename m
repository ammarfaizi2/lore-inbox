Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313707AbSD3Qve>; Tue, 30 Apr 2002 12:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313711AbSD3Qvd>; Tue, 30 Apr 2002 12:51:33 -0400
Received: from bdsl.66.13.29.10.gte.net ([66.13.29.10]:29824 "EHLO
	Bluesong.NET") by vger.kernel.org with ESMTP id <S313707AbSD3Qvd>;
	Tue, 30 Apr 2002 12:51:33 -0400
Message-Id: <200204301700.g3UH01v04279@Bluesong.NET>
Content-Type: text/plain; charset=US-ASCII
From: "Jack F. Vogel" <jfv@trane.bluesong.net>
Reply-To: jfv@bluesong.net
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Andrew Theurer <habanero@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Hyperthreading and physical/logical CPU identification
Date: Tue, 30 Apr 2002 10:00:01 -0700
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200204291849.NAA23906@popmail.austin.ibm.com> <26950000.1020120115@flay>
Cc: cleverdj@us.ibm.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 April 2002 03:41 pm, Martin J. Bligh wrote:
> > The problem is, I have 4 physical processors, but kernel.org kernels so
> > far do not recognize all of them.  2.4.18 will find 3, while 2.5.11 will
> > find only 2 (BIOS hyperthreading support off, no acpismp=force). 
> > However, on 2.5.11, if I enable hyperthreading (thru BIOS and
> > acpismp=force, I see 4 processors.
>
> When you say the kernel doesn't recognise all of the physical processors,
> do you mean it doesn't see them in the MPS/ACPI table, or that they fail to
> boot? Can you post your boot log?
>
> I see you have a "us.ibm.com" email address ... is this machine an x440,
> one of it's smaller brethren, or something totally different?

If it is the x440 then the problem is the xapic and you need James Cleverdon's
summit patch for all processors to be seen and properly initialized. Email
James or me if you need a pointer.

-- 
Jack F. Vogel
IBM  Linux Solutions
jfv@us.ibm.com  (work)
jfv@Bluesong.NET (home)
