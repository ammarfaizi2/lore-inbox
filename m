Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265928AbRFZHdd>; Tue, 26 Jun 2001 03:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265930AbRFZHdY>; Tue, 26 Jun 2001 03:33:24 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:4101 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S265928AbRFZHdQ>; Tue, 26 Jun 2001 03:33:16 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac12 kernel oops
In-Reply-To: <9h7oho$9dc$1@ns1.clouddancer.com>
In-Reply-To: <730.993486023@ocs3.ocs-net> Your message of    "Mon, 25 Jun 2001 09:02:19 MST."    <20010625160219.84967784D9@mail.clouddancer.com> <9h7oho$9dc$1@ns1.clouddancer.com>
Reply-To: klink@clouddancer.com
Message-Id: <20010626073314.C208C7846A@mail.clouddancer.com>
Date: Tue, 26 Jun 2001 00:33:14 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>Hmm, I would have thought that /proc was more up to date, because it
>>would reflect changes.  No reboot, never even considered it (I've
>>rescued too many junior sysadmins that think rebooting is _the_ answer).
>
>/proc/ksyms is dynamic, it changes as modules are loaded and unloaded.
>And often the oops is so bad that the machine is dead so reboot is the
>only option, ksyms after reboot may be for a completely different
>kernel.  If you want accurate ksyms and lsmod data to feed into
>ksymoops, 'man insmod' and read section 'KSYMOOPS ASSISTANCE'.

OK, I added the cron task and directory, perhaps I need them sometime.
In any event, thanks for the info.  This certainly seems very well
thought out!


-- 
"Or heck, let's just make the VM a _real_ Neural Network, that self
trains itself to the load you put on the system. Hideously complex and
evil?  Well, why not wire up that roach on the floor, eating that stale
cheese doodle. It can't do any worse job on VM that some of the VM
patches I've seen..."  -- Jason McMullan

ditto
