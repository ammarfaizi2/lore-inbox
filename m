Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135612AbRDXNgT>; Tue, 24 Apr 2001 09:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135609AbRDXNgI>; Tue, 24 Apr 2001 09:36:08 -0400
Received: from memphis.cbn.net.id ([202.158.3.16]:19985 "HELO
	memphis.cbn.net.id") by vger.kernel.org with SMTP
	id <S135613AbRDXNf5>; Tue, 24 Apr 2001 09:35:57 -0400
Date: Tue, 24 Apr 2001 20:37:51 +0700 (JAVT)
From: <imel96@trustix.co.id>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Single user linux
In-Reply-To: <Pine.LNX.3.95.1010424090323.12078B-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33.0104242029140.16230-100000@tessy.trustix.co.id>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Apr 2001, Richard B. Johnson wrote:
> You are on the wrong list. You don't modify the kernel to make
> a "single-user" machine. You modify the password file in /etc/passwd.
> Until you know, and completely understand this, you will be laughed at.
>
> When an interactive process is started, /bin/login gets the new
> process information from the /etc/passwd file just before it gets
> overwritten (exec) by the shell shown in that same password file.
>
> If you want your accounts to have root privs, you set the UID and
> GID fields in the password file to 0 and 0 respectively. I would
> not suggest that you connect your computer to a network if you
> do this.

thank you very much fyi.
if just you tried to understand it a little further:
i didn't change all uid/gid to 0!

why? so with that radical patch, users will still have
uid/gid so programs know the user's profile.

if everyone had 0/0 uid/gid, pine will open /var/spool/mail/root,
etc.


		imel


