Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133076AbRDVADx>; Sat, 21 Apr 2001 20:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133079AbRDVADn>; Sat, 21 Apr 2001 20:03:43 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:22034 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S133076AbRDVADa>;
	Sat, 21 Apr 2001 20:03:30 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104220003.f3M03R4194742@saturn.cs.uml.edu>
Subject: Re: [kbuild-devel] CML2 1.1.3 is available
To: azz@gnu.org (Adam Sampson)
Date: Sat, 21 Apr 2001 20:03:27 -0400 (EDT)
Cc: esr@thyrsus.com, linux-kernel@vger.kernel.org
In-Reply-To: <87itk04gus.fsf@cartman.azz.us-lot.org> from "Adam Sampson" at Apr 20, 2001 12:20:11 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Sampson writes:
> "Eric S. Raymond" <esr@thyrsus.com> writes:

>> If there were already a library in ths stock Python distribution to
>> digest .Xdefaults files I might consider this.  Perhaps I'll write
>> one.
>
> No, please don't! .Xdefaults files as loaded by xrdb can contain cpp
> directives which can depend on the arguments given to xrdb ("xrdb
> -DBIGTERM .Xdefaults", for instance), so you can't assume that what
> you read from .Xdefaults is the user's setup, even if you emulate
> cpp. You also shouldn't assume that the user's HOME is on the machine
> where they loaded their resources from (suppose I start an X session
> on my workstation, then ssh over to a server and run CML2; it would
> then read server:~/.Xdefaults rather than workstation:~/.Xdefaults).
> It's much more sensible to use the normal X mechanisms for reading
> resources from the X server.

The above absurdity is exactly why newer toolkits don't bother
to support this config mechanism. There isn't any way to have
the app support an "Edit --> Preferences --> Save" with this.

If the Python/Tk stuff (or whatever it is Eric is using) doesn't
yet have a modern dotfile for this sort of thing, then we've just
stumbled across a nice project.

