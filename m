Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289015AbSA3JiG>; Wed, 30 Jan 2002 04:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289016AbSA3Jh5>; Wed, 30 Jan 2002 04:37:57 -0500
Received: from femail36.sdc1.sfba.home.com ([24.254.60.26]:5528 "EHLO
	femail36.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S289015AbSA3Jhm>; Wed, 30 Jan 2002 04:37:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Jeff Garzik <garzik@havoc.gtf.org>,
        Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Wed, 30 Jan 2002 04:38:51 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <200201290446.g0T4kZU31923@snark.thyrsus.com> <200201300757.g0U7v1t07728@Port.imtp.ilyichevsk.odessa.ua> <20020130032920.H32317@havoc.gtf.org>
In-Reply-To: <20020130032920.H32317@havoc.gtf.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020130093741.JKWP18592.femail36.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 January 2002 03:29 am, Jeff Garzik wrote:
> On Wed, Jan 30, 2002 at 09:57:02AM -0200, Denis Vlasenko wrote:
> > On 30 January 2002 00:46, Dave Jones wrote:
> > > On Tue, Jan 29, 2002 at 09:51:00PM +0200, Kai Henningsen wrote:
> > >  > >   - cleanliness
> > >  > >   - concept
> > >  > >   - timing
> > >  > >   - testing
> > >  >
> > >  > IIRC, the number 33 referred to esr's Configure.help patch. Which of
> > >  > these did he violate?
> > >
> > >  Timing.  Linus was busy focusing on the block layer.
> >
> > Sounds alarming. Linus didn't take documentation updates from designated
> > maintainer? For many months? I can't believe in argument that updates
> > were able to break _anything_, it's only documentation, right? I could
> > understand this if these updates were sent by little known person, but
> > Eric?!
> >
> > Clearly a scalability problem here :-)
>
> Oh-my-lord.  Please re-read this thread, and especially Linus's
> 2.5.3-pre5 changelog announcement.
>
> Configure.help needed to be split up.  Eric?! was told this repeatedly,
> but he did not listen.  Hopefully he will listen to feedback regarding
> CML2...  He has even been told repeatedly that he does not
> listen to feedback ;-)
>
> 	Jeff, chuckling

I spoke to Eric earlier today.  (We're co-doing a presenatation at LinuxWorld 
Expo on thursday.)

His take on it was that he understood that Configure.help needed to be split 
up, but since the file was used by CML1 and he was NOT the CML1 maintainer, 
he didn't believe he had the authority to unilaterally change the file format 
in a way that would seriously break CML1.  (And, as it happens, now that the 
change has gone in, it seems the existing configurators are currently broken 
and have no help.)

Considering how much he's been warned so far about the need for CML2 to 
maintain as much compatability as possible with CML1, change as little 
behavior as possible in its first version, and not to make intrustive changes 
into the rest of the codebase...  I think he expected to be flamed alive if 
he broke up the help file before CML2 went in.

I.E. There was a miscommunication.  (The drop from Linus was an actual 
reject, but without an explanation of why it was rejected the reject didn't 
get resolved.  For 33 consecutive versions...)

Rob
