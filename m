Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274867AbRIUXGh>; Fri, 21 Sep 2001 19:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274866AbRIUXG1>; Fri, 21 Sep 2001 19:06:27 -0400
Received: from pat.uio.no ([129.240.130.16]:52355 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S274868AbRIUXGT>;
	Fri, 21 Sep 2001 19:06:19 -0400
MIME-Version: 1.0
Message-ID: <15275.51188.271719.562445@charged.uio.no>
Date: Sat, 22 Sep 2001 01:06:28 +0200
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS daemons in D state for 2 minutes at shutdown
In-Reply-To: <7126003481.20010921154654@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <3531863216.20010920164639@port.imtp.ilyichevsk.odessa.ua>
	<shswv2tpyvq.fsf@charged.uio.no>
	<1978861221.20010921110112@port.imtp.ilyichevsk.odessa.ua>
	<15275.1922.771056.17407@charged.uio.no>
	<7126003481.20010921154654@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == VDA  <VDA@port.imtp.ilyichevsk.odessa.ua> writes:

     > Hello Trond, Friday, September 21, 2001, 12:25:22 PM, you
     > wrote:
    TM> Bullshit. killall5 is definitely *not* a well accepted method
    TM> for shutting down applications. Try doing that while your
    TM> network is running via a ppp link...

     > And what is the well accepted method? I'd like to fix my
     > system, so please somebody enlighten me...

Use a combination of 'ps' and 'kill -9' or even 'killall'. Anything
that actually selects the nfsd daemons and *NOT* the portmapper.
Grab a copy of nfs-utils and look at the init script included
there if you still don't understand...

Cheers,
  Trond
