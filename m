Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135623AbRDXNwI>; Tue, 24 Apr 2001 09:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135626AbRDXNur>; Tue, 24 Apr 2001 09:50:47 -0400
Received: from [24.70.141.118] ([24.70.141.118]:26610 "EHLO asdf.capslock.lan")
	by vger.kernel.org with ESMTP id <S135627AbRDXNuV>;
	Tue, 24 Apr 2001 09:50:21 -0400
Date: Tue, 24 Apr 2001 09:50:02 -0400 (EDT)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Roland Seuhs <rseuhs@aon.at>
cc: <imel96@trustix.co.id>, Alexander Viro <viro@math.psu.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Single user linux
In-Reply-To: <01042415035700.00839@server>
Message-ID: <Pine.LNX.4.33.0104240946540.21785-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
X-Spam-To: uce@ftc.gov
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2001, Roland Seuhs wrote:

>> with multi-user concept, conceptually there should be an
>> administrator to create account, grant permission, etc.
>> no my sister doesn't want that. i bet there are billions of
>> people not willing to learn how to use a computer, they just
>> want to use it.
>>
>> and yes, mobile devices access network.
>
>KDE2.1.1 comes with a password disabling feature. That means that you can log
>in without password (you have to use KDM). For everything else (ftp, telnet,
>ssh, text-console-login - whatever) you still need the password.

ftp://people.redhat.com/mharris/hacks/mingetty

This allows you to do:

5:2345:respawn:/sbin/mingetty --autologin=mharris tty5

in /etc/inittab at boot time.  The only problem with it is if you
upgrade and mingetty gets upgraded the standard mingetty doesn't
grok --autologin so it explodes and respawns until init kills it.

I'm rewriting it to use a config file instead, and might possibly
change the name if Florian doesn't mind.



----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

