Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281340AbRKPMBc>; Fri, 16 Nov 2001 07:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281317AbRKPMBW>; Fri, 16 Nov 2001 07:01:22 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:44298 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S281314AbRKPMBH>; Fri, 16 Nov 2001 07:01:07 -0500
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: nfs problem: hp|aix-server --- linux 2.4.15pre5 client
Date: Fri, 16 Nov 2001 12:01:06 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9t2v62$7g0$1@ncc1701.cistron.net>
In-Reply-To: <20011115222920.A9929@ludwig2.science-computing.de> <shssnbf37td.fsf@charged.uio.no> <15348.63313.961267.735216@stderr.science-computing.de> <15348.64613.465429.628445@charged.uio.no>
X-Trace: ncc1701.cistron.net 1005912066 7680 195.64.65.67 (16 Nov 2001 12:01:06 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <15348.64613.465429.628445@charged.uio.no>,
Trond Myklebust  <trond.myklebust@fys.uio.no> wrote:
>>>>>> " " == Birger Lammering <b.lammering@science-computing.de> writes:
>
>     > not reproduce the Ooops with the HP nfs server. But still: The
>     > Kernel complains about: "NFS: short packet in readdir reply!" 
>
>That's because the HP is returning a READDIR reply that is larger than
>the buffer size we specified. When this happens, we truncate the reply
>at the last valid record before the buffer overflow, and print out the
>above message.

Shouldn't the message then be "NFS: too large packet in readdir reply!" ?

Mike.
-- 
"Only two things are infinite, the universe and human stupidity,
 and I'm not sure about the former" -- Albert Einstein.

