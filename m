Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287631AbSCPSce>; Sat, 16 Mar 2002 13:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291625AbSCPScO>; Sat, 16 Mar 2002 13:32:14 -0500
Received: from acolyte.thorsen.se ([193.14.93.247]:20741 "HELO
	acolyte.hack.org") by vger.kernel.org with SMTP id <S287631AbSCPSby>;
	Sat, 16 Mar 2002 13:31:54 -0500
From: Christer Weinigel <wingel@acolyte.hack.org>
To: jgarzik@mandrakesoft.com
Cc: lm@bitmover.com, linux-kernel@vger.kernel.org
In-Reply-To: <3C938611.3090008@mandrakesoft.com> (message from Jeff Garzik on
	Sat, 16 Mar 2002 12:51:13 -0500)
Subject: Re: Problems using new Linux-2.4 bitkeeper repository.
In-Reply-To: <200203161608.g2GG8WC05423@localhost.localdomain> <3C9372BE.4000808@mandrakesoft.com> <20020316083059.A10086@work.bitmover.com> <3C9375B7.3070808@mandrakesoft.com> <20020316085213.B10086@work.bitmover.com> <3C937B82.60500@mandrakesoft.com> <20020316091452.E10086@work.bitmover.com> <3C938027.4040805@mandrakesoft.com> <20020316093832.F10086@work.bitmover.com> <3C938611.3090008@mandrakesoft.com>
Message-Id: <20020316183150.13FDEF5B@acolyte.hack.org>
Date: Sat, 16 Mar 2002 19:31:50 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> Hence my suggestion for a short term solution that's immediately useful 
> -- allowing some way to answer "local changes take precedence 100% of 
> the time" or "remote changes ..." with a single command.  That was my 
> hack solution that I thought would people might find useful when stuck 
> with the duplicate-patch situation.
> 
> In the command line merge tool, when merging a file-create, "rla" would 
> cause the current file conflict, and all future file-create conflicts, 
> to be "won" by the remote side -- essentially creating the effect of 
> typing "rl" 300 times.
> Apply similar logic to the file-rename merge case.  I think the merge 
> command I used in 100% of the cases, during that merge, was 'r'.

One variant of this would be to automatically use the remote file as
long as the file contents are the same.  That way, if I apply a patch
locally and Marcello/Linus later apply the same patch and put it into
the official tree, I can use the official version.  This would
probably handle most of the conflicts I have seen so far.  If there
are any "real" conflicts, I can handle them manually.  

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"
