Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312706AbSDKSN0>; Thu, 11 Apr 2002 14:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312711AbSDKSNZ>; Thu, 11 Apr 2002 14:13:25 -0400
Received: from mx1.afara.com ([63.113.218.20]:59260 "EHLO afara-gw.afara.com")
	by vger.kernel.org with ESMTP id <S312706AbSDKSNY>;
	Thu, 11 Apr 2002 14:13:24 -0400
User-Agent: Pan/0.11.2 (Unix)
From: "Thomas Duffy" <tduffy@afara.com>
To: "Steffen Persvold" <sp@scali.com>, linux-kernel@vger.kernel.org
Subject: Re: IRIX NFS server and Linux NFS client
Date: Thu, 11 Apr 2002 11:13:02 -0700
In-Reply-To: <Pine.LNX.4.30.0204110928530.28565-100000@elin.scali.no> <Pine.LNX.4.30.0204111218440.30970-100000@elin.scali.no>
Message-ID: <AFARA-EXXsNQptgFrYI0000121c@afara-ex.afara.com>
X-OriginalArrivalTime: 11 Apr 2002 18:13:15.0376 (UTC) FILETIME=[8C978F00:01C1E184]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2002 03:23:15 -0700, Steffen Persvold wrote:

> On Thu, 11 Apr 2002, Steffen Persvold wrote:
> 
>> Hi all,
>>
>> Is there any reason why my Linux NFS client (kernel 2.4.18
>> nfs-utils-0.3.1-13.7.2.1 from RedHat 7.2) is not able to mount a
>> directory exported from an IRIX server in NFSv3 (not sure which version
>> of IRIX yet, if this is important I will find out). NFSv2 works fine,
>> but if I try to force NFSv3 I get "Connection refused".

What version of IRIX are you using?

There was a fix put into IRIX in the 6.5.12/13 timeframe that made it
more compatible with Linux.  Make sure you are updated to at least that
release.

-tduffy
