Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269693AbRH0XGW>; Mon, 27 Aug 2001 19:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269718AbRH0XGM>; Mon, 27 Aug 2001 19:06:12 -0400
Received: from mail.spylog.com ([194.67.35.220]:39838 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S269693AbRH0XFz>;
	Mon, 27 Aug 2001 19:05:55 -0400
Date: Tue, 28 Aug 2001 03:06:07 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Updated Linux kernel preemption patches
Message-ID: <20010828030607.A32428@spylog.ru>
Mail-Followup-To: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <998877465.801.19.camel@phantasy> <20010827093835.A15153@oisec.net> <3B8AA02D.6F7561AB@lexus.com> <998941465.1993.9.camel@phantasy> <998947154.11860.30.camel@phantasy> <20010827232415.A670@oisec.net> <998948441.12267.9.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <998948441.12267.9.camel@phantasy>
User-Agent: Mutt/1.3.20i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Robert Love,

> > It still borks, probably you are having other options in your kernel config
> > and sections you don't use may depend on dec_and_lock
> 
> No, I have places in my kernel where atomic_dec_and_lock is used.  In
> fact, one of the functions I was pasted where it broke was mmput() in
> kernel.S (i think from fork.c).  I have that function, and it uses
> atomic_dec_and_lock...
> 
> So the problem is most certainly something to do with your configuration
> not getting the dependency right to use atomic_dec_and_lock
> 
> Out of curiosity, what CONFIG CPU are you defined to use? 

#
CONFIG_X86=y
...
CONFIG_MPENTIUMIII=y
...



> > First get it to work, and then spend time on keeping it current with alan's
> > and linus' tree.
> 
> I am working, but it is not my code.  I am merely trying to keep it in
> sync with the trees.  I am trying to get it working for those who it
> does not compile for, but it works for me and others, so it is hard.
 

-- 
bye.
Andrey Nekrasov, SpyLOG.
