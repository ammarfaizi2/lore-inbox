Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315967AbSENSZt>; Tue, 14 May 2002 14:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315969AbSENSZs>; Tue, 14 May 2002 14:25:48 -0400
Received: from daimi.au.dk ([130.225.16.1]:1616 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S315967AbSENSZr>;
	Tue, 14 May 2002 14:25:47 -0400
Message-ID: <3CE15684.989AB0D3@daimi.au.dk>
Date: Tue, 14 May 2002 20:25:08 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Mielke <mark@mark.mielke.cc>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
In-Reply-To: <200205131709.g4DH9Fjv006328@pincoya.inf.utfsm.cl> <3CE1300A.990919E2@daimi.au.dk> <20020514115655.A22935@mark.mielke.cc>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:
> 
> 1) You can always submit a patch, and see whether other people approve of it.

I might decide to do that. But I wouldn't spend the time
without first knowing if:
a) There were some very good reasons not to change it.
b) Somebody knowing this code by heart could write a
   patch in five minutes.

> 
> 2) If you won't do it, why would somebody else working on something that
>    provides lower latency to user process response time, or improvement
>    to the IDE drivers, take the time to deal with this issue?

I don't intend to try to force somebody to do it, if
they have more important things to do.

> 
> As it is, there are plenty of other denial-of-service type attacks
> that can be performed that would be more effective than the 'exploit'
> you have mentioned. Your proposal would need to be 'fix them all', if
> your complaint is that Linux has a security hole.

It surely would be nice to prevent all DoS attacks. But
of course that would require a lot of work. However I
think most other DoS attacks could be solved by a reboot.

> 
> If you complaint is that an administrator might mistakenly believe
> that it is a security feature, I suggest your understand that this is
> merely one issue of quite a few. If the administrator is not aware of
> issues such as these, perhaps they should not be an administrator?

We cannot blame administrators before the documentation
has been changed.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
