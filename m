Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272636AbRIGM6c>; Fri, 7 Sep 2001 08:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272639AbRIGM6W>; Fri, 7 Sep 2001 08:58:22 -0400
Received: from va.flyingbuttmonkeys.com ([207.198.61.36]:8653 "EHLO
	va.flyingbuttmonkeys.com") by vger.kernel.org with ESMTP
	id <S272636AbRIGM6H>; Fri, 7 Sep 2001 08:58:07 -0400
Message-ID: <000c01c1379c$c427c0d0$81d4870a@cartman>
Reply-To: "Michael Rothwell" <rothwell@holly-springs.nc.us>
From: "Michael Rothwell" <rothwell@holly-springs.nc.us>
To: "Neil Brown" <neilb@cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <002b01c136e1$3bb36a80$81d4870a@cartman> <15256.46017.7716.689482@notabene.cse.unsw.edu.au>
Subject: Re: nfs is stupid ("getfh failed")
Date: Fri, 7 Sep 2001 08:58:18 -0400
Organization: Holly Springs, NC
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Neil Brown" <neilb@cse.unsw.edu.au>

> This is not allowed, and makes no sense.

It apparently is (or was, anyway) allowed, because it worked until the
server was rebooted. Fluke?
Are you saying that, if I export "/export", I can mount "/export/home" from
a client machine? That's nice.

> Simply remove the second line and your problems should go away.

Thanks. I actually switched to two explicit exports; /export/files and
/export/home, which works.


> > On a related topic, will Linux ever have a better file-service protocol?
>
> This is an unanswerable question.  The future of Linux is completely
> undefined until it happens.

Just wondering if there's been any talk, plans, etc. of an alternative for
NFS.

> What exactly do you mean by "better" anyway?

Better security, better performance.

Thanks,

-M

