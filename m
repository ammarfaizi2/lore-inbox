Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290494AbSA3Tjq>; Wed, 30 Jan 2002 14:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290495AbSA3Tjh>; Wed, 30 Jan 2002 14:39:37 -0500
Received: from femail35.sdc1.sfba.home.com ([24.254.60.25]:42204 "EHLO
	femail35.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S290494AbSA3TjV>; Wed, 30 Jan 2002 14:39:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Jeff Garzik <garzik@havoc.gtf.org>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Wed, 30 Jan 2002 14:40:25 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <200201290446.g0T4kZU31923@snark.thyrsus.com> <20020130093741.JKWP18592.femail36.sdc1.sfba.home.com@there> <20020130044305.B11267@havoc.gtf.org>
In-Reply-To: <20020130044305.B11267@havoc.gtf.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020130193920.XLYO7009.femail35.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 January 2002 04:43 am, Jeff Garzik wrote:
> On Wed, Jan 30, 2002 at 04:38:51AM -0500, Rob Landley wrote:
> > Considering how much he's been warned so far about the need for CML2 to
> > maintain as much compatability as possible with CML1,
>
> Pardon me while I laugh my ass off.

[waits...]

> > behavior as possible in its first version, and not to make intrustive
> > changes into the rest of the codebase...  I think he expected to be
> > flamed alive if he broke up the help file before CML2 went in.
> >
> > I.E. There was a miscommunication.  (The drop from Linus was an actual
> > reject, but without an explanation of why it was rejected the reject
> > didn't get resolved.  For 33 consecutive versions...)
>
> Getting told something point blank, multiple times, is definitely
> -something-.  I suppose you could call that miscommunication.

I'm under the impression CML2 already supports the split-up per-directory 
help files, and did long before Linus actually split it up.  Therefore, Eric 
hasn't entirely been ignoring the issue, has he?

Yes, I would call it a miscommunication.

(By the way, if you really want to fix the current cml1 stuff in the 
cheesiest manner possible, what would be wrong with some variant of "find . 
-name "*.hlp" | xargs cat > oldhelpfile.hlp"?  Then the old help file becomes 
a generated file of the new help files.  Why mess with tcl/tk?  Put it in the 
make file as a dependency.  Pardon me if somebody fixed it last night, I seem 
have 91 emails to wade through since then on the patch penguin fallout 
alone...)

> 	Jeff

Rob
