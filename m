Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288980AbSAUAoB>; Sun, 20 Jan 2002 19:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288984AbSAUAnw>; Sun, 20 Jan 2002 19:43:52 -0500
Received: from mail3.home.nl ([213.51.129.227]:3052 "EHLO mail3.home.nl")
	by vger.kernel.org with ESMTP id <S288980AbSAUAnk>;
	Sun, 20 Jan 2002 19:43:40 -0500
From: Frank van de Pol <fvdpol@home.nl>
Date: Mon, 21 Jan 2002 00:20:41 +0100
To: Keith Owens <kaos@ocs.com.au>
Cc: "Mr. James W. Laferriere" <babydr@baby-dragons.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Hardwired drivers are going away?
Message-ID: <20020121002041.B1958@idefix.fvdpol.home.nl>
In-Reply-To: <Pine.LNX.4.44.0201181632000.18867-100000@filesrv1.baby-dragons.com> <14160.1011396163@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14160.1011396163@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.4.13-ac4 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, Jan 19, 2002 at 10:22:43AM +1100, Keith Owens wrote:
> On Fri, 18 Jan 2002 17:20:02 -0500 (EST), 
> "Mr. James W. Laferriere" <babydr@baby-dragons.com> wrote:
> >	Linux doesn't have a method to load encrypted & signed modules at
> >	this time .
> 
> And never will.  Who loads the module - root.  Who maintains the list
> of signatures - root.  Who controls the code that verifies the
> signature - root.
> 
> Your task Jim, should you choose to accept it, is to make the kernel
> distinguish between a good use of root and a malicious use by some who
> has broken in and got root privileges.  When you can do that, then we
> can add signed modules.
> 

If you want to secure your box, why don't you simply put a lock on it and
throw away the key? Really, what might help the paranoid admins in this case
is a setting in the kernel which basically disables the ability to load or
unload modules. Of course once set this setting can not been turned with
rebooting the box.

Frank.


-- 
+---- --- -- -  -   -    - 
| Frank van de Pol                  -o)    A-L-S-A
| FvdPol@home.nl                    /\\  Sounds good!
| http://www.alsa-project.org      _\_v
| Linux - Why use Windows if we have doors available?
