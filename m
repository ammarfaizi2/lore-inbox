Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbSK0XJy>; Wed, 27 Nov 2002 18:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbSK0XJx>; Wed, 27 Nov 2002 18:09:53 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:39173 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S264919AbSK0XJx>;
	Wed, 27 Nov 2002 18:09:53 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Patch?: module-init-tools/modprobe.c - use modules.dep 
In-reply-to: Your message of "Wed, 27 Nov 2002 16:02:08 +1100."
             <20021127225227.6B1952C088@lists.samba.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Nov 2002 10:17:03 +1100
Message-ID: <19191.1038439023@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2002 16:02:08 +1100, 
Rusty Russell <rusty@rustcorp.com.au> wrote:
>In message <200211261902.LAA04005@baldur.yggdrasil.com> you write:
>> >I'd prefer a static parser which turns modules.conf into modprobe.conf
>> >rather than reimplementing modules.conf (config files which are so
>> >complex they need a "hobbled mode" in case they are called from
>> >untrusted context are in trouble already).
>> 
>> 	Could we just use modules.conf and not support certain
>> commands?
>
>Hmm, I'd prefer to convert.

I hope you are going to check with everybody using complex modules.conf
files before you remove all the facilities.  I know that there are
people who rely on being able to run commands in modules.conf to suit
their system.

