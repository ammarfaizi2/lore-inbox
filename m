Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269551AbRHMABq>; Sun, 12 Aug 2001 20:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269583AbRHMABg>; Sun, 12 Aug 2001 20:01:36 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:37136 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S269551AbRHMABY>; Sun, 12 Aug 2001 20:01:24 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: VM nuisance
In-Reply-To: <9l5v9a$ha9$1@ns1.clouddancer.com>
In-Reply-To: <Pine.LNX.4.33.0108121506100.18332-100000@druid.if.uj.edu.pl> <Pine.LNX.4.33L.0108102347050.3530-100000@imladris.rielhome.conectiva> <9l5v9a$ha9$1@ns1.clouddancer.com>
Reply-To: klink@clouddancer.com
Message-Id: <20010813000136.8BC4A78628@mail.clouddancer.com>
Date: Sun, 12 Aug 2001 17:01:36 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In clouddancer.list.kernel, you wrote:
>
>> No.  The problem is that whenever I change something to
>> the OOM killer I get flamed.
>>
>> Both by the people for whom the OOM killer kicks in too
>> early and by the people for whom the OOM killer now doesn't
>> kick in.
>>
>> I haven't got the faintest idea how to come up with an OOM
>> killer which does the right thing for everybody.
>
>How about adding some sort of per-process priority (i.e. a la nice) which
>would determine the order in which they would be OOMed? Then we could
>safely run X with a kigh KillMe and Netscape with an even higher KillMe
>and we would probably avoid the something useing too much memory let's
>kill root's shell...
>
>[i.e. if a lower KillMe proc runs out of memory we kill off the process
>with the highest KillMe using most mem and can safely give this mem to the
>proc which just ran out]


Ah, so you kill X because of the high KillMe you've assigned?  I can
see that this idea quickly leads to dependecies and their problems (if
I kill X, I therefore have killed all Netscapes too...  but if I kill
a dhcp, without killing Netscape first, netscape is useless ... blah
blah blah).


If there is insufficient memory for a process, tell it to sit on it
and spin, especially since : "I haven't got the faintest idea..."
Stop trying to make up for the sysadmin bozo.


-- 
Windows 2001: "I'm sorry Dave ...  I'm afraid I can't do that."

