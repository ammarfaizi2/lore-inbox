Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318059AbSHaXYl>; Sat, 31 Aug 2002 19:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318060AbSHaXYl>; Sat, 31 Aug 2002 19:24:41 -0400
Received: from s64-180-126-48.bc.hsia.telus.net ([64.180.126.48]:8434 "EHLO
	www.e-servicesystem.com") by vger.kernel.org with ESMTP
	id <S318059AbSHaXYk> convert rfc822-to-8bit; Sat, 31 Aug 2002 19:24:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Bruce Lynes <dlynes@shaw.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: SMB browser
Date: Sat, 31 Aug 2002 16:26:54 -0700
X-Mailer: KMail [version 1.4]
References: <3D709AB7.705@linkvest.com> <3D70A909.8080105@inet6.fr> <3D7117C3.5060307@linkvest.com>
In-Reply-To: <3D7117C3.5060307@linkvest.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208311626.54642.dlynes@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 August 2002 12:23, Jean-Eric Cuendet wrote:

> To access files on the server share, the client must send authentication
> tockens. This should be send by the daemon and must be get from a file
> on the disk that each user shuold have (the kerberos ticket got by PAM).
> If no file (or invalid one) is available, then it should be accessed as
> guest.

And if they're using shadow passwords and not PAM?

> > How will you handle users with multiple logins on a Domain/Machine ?
>
> The user will already been logged on ONE domain controller.

And if they're not using an LM Domain?

Sorry, but I don't know anything about writing drivers under Linux yet...just 
starting so I can get voice over IP working on a proprietary card.  However, 
I thought I'd interject some ideas, to give you some ideas on how to improve 
the initial ideas.  It sounds useful, but even in my highly unspecialized 
environment, it wouldn't work because I don't use a domain controller, and I 
don't use shadow passwords, not PAM.

Most of the machines on our network use Slackware (which doesn't use PAM), and 
they're running on a Windows workgroup, not a domain.
