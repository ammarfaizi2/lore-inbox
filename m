Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287450AbSBIU70>; Sat, 9 Feb 2002 15:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287565AbSBIU7P>; Sat, 9 Feb 2002 15:59:15 -0500
Received: from [62.14.192.118] ([62.14.192.118]:26630 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S287450AbSBIU6z>;
	Sat, 9 Feb 2002 15:58:55 -0500
Date: Sat, 9 Feb 2002 21:57:50 +0100 (CET)
From: Pau Aliagas <linuxnow@wanadoo.es>
X-X-Sender: pau@pau.intranet.ct
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: pull vs push (was Re: [bk patch] Make cardbus compile in -pre4)
In-Reply-To: <20020209122649.E13735@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0202092152440.17916-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Feb 2002, Larry McVoy wrote:

> This is my problem.  You could help if you could tell me what exactly 
> are the magic wands to wave such that you can ssh in without typing
> a password.  I know about ssh-agent but that doesn't help for this, 
> I know that in certain cases ssh lets me in without anything.  I thought
> there was some routine where you ssh-ed one way and then the other way
> and it left enough state that it trusted you, does any ssh genuis out 
> there know what I'm talking about?  If I have this, I can set up the
> cron job, I'm sure this is obvious and I'm just overlooking something
> but I can't find it.

Just get the .ssh/id_dsa.pub from the client you want to allow in without 
a password and copy it inside .ssh/authorized_keys2 in the server.

ssh-agent is useful if you protect your keys with a password so that you
don't have to retype the password to unblock you own key over and over.  
Nothing to do with accessing other sites.

If you need any help just tell me.
Pau

