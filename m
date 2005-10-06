Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbVJFJaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVJFJaN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 05:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVJFJaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 05:30:13 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:33252 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750768AbVJFJaL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 05:30:11 -0400
Message-ID: <4344EF0F.90402@aitel.hist.no>
Date: Thu, 06 Oct 2005 11:31:59 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <20051005095653.GK10538@lkcl.net> <200510051847.j95IlRTS012444@laptop11.inf.utfsm.cl>            <20051005230309.GO10538@lkcl.net> <200510060803.j9683aXK026732@turing-police.cc.vt.edu>
In-Reply-To: <200510060803.j9683aXK026732@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

>The part that you managed to miss is that this is MAC - *Mandatory*
>Access Control.  This means that the *sysadmin* gets to say "this user
>can't look at that file" - and there's nothing(*) either the owner of the
>file or the user can do about it.  There's no chmod or chattr or chacl
>command that the owner can issue to let somebody else read it - that's
>the whole *point* of MAC.
>
>(*) Well.. almost nothing.  The owner *may* be able to copy the contents
>of the file to another file that the other user is allowed to read.  On the
>other hand, the ability to do this would generally indicate a buggy policy....
>  
>
Seems to me there is no use taking away the owners ability to chmod,
precisely because the owner always can get around that. (Unless
the owner doesn't even have the right to read his own file.)

You can have a restricted "copy" program, but nothing prevents a
user from making his own copy program, if he can read the file.
Or the user can load the file into the intended app, and "save as"
to some other filename and directory.  Or the user can do a screendump,
or even take a picture of the screen. 

Company policy may of course forbid the user to bring a camera, just as it
might forbid the user to do "chmod o+r" on important files.  I am not
sure that we need the OS to try to enforce such things. 

Helge Hafting

