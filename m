Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313974AbSDKDtZ>; Wed, 10 Apr 2002 23:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313975AbSDKDtY>; Wed, 10 Apr 2002 23:49:24 -0400
Received: from ip68-7-112-74.sd.sd.cox.net ([68.7.112.74]:29701 "EHLO
	clpanic.kennet.coplanar.net") by vger.kernel.org with ESMTP
	id <S313974AbSDKDtY>; Wed, 10 Apr 2002 23:49:24 -0400
Message-ID: <007b01c1e10b$93b27300$7e0aa8c0@bridge>
From: "Jeremy Jackson" <jerj@coplanar.net>
To: "Suparna Bhattacharya" <suparna@in.ibm.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        <linux-kernel@vger.kernel.org>, <lkcd-devel@lists.sourceforge.net>
In-Reply-To: <00c501c1dce3$0ed806d0$7e0aa8c0@bridge> <1674141067.1018028922@[10.10.2.3]> <003301c1dd16$855df1b0$7e0aa8c0@bridge> <3CB144BE.9DC8B034@in.ibm.com>
Subject: Re: Faster reboots (and a better way of taking crashdumps?)
Date: Wed, 10 Apr 2002 20:47:17 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Should this go off lkml?

----- Original Message ----- 
From: "Suparna Bhattacharya" <suparna@in.ibm.com>
Sent: Monday, April 08, 2002 12:20 AM
 
> > I'm currently researching combining the two, to create a LinuxBIOS
> > firmware debug console, which will allow complete crash dump to
> > be taken after a hardware reset, with the smallest possible Heisenburg
> > effect, aside from a hardware debugger.
> 
> So how is the actual writeout accomplished ?(via LinuxBIOS ?)

well it's just an idea just now. In order to do this from code in rom,
I immagine it would just dump physical memory to a raw partition,
using polling ide drivers in LinuxBIOS.  This is probably a step
backwards, compared to modern crash dumps, but it would
allow zero alteration of memory.

It may be possible to do with a standard flash size of 128KiB,
though, which would allow virtually all motherboards to support it.

Jeremy
