Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262622AbRFHS6c>; Fri, 8 Jun 2001 14:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263414AbRFHS6V>; Fri, 8 Jun 2001 14:58:21 -0400
Received: from alcove.wittsend.com ([130.205.0.20]:15508 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S262707AbRFHS6G>; Fri, 8 Jun 2001 14:58:06 -0400
Date: Fri, 8 Jun 2001 14:56:46 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: "Michael H . Warfield" <mhw@wittsend.com>, Chris Boot <bootc@worldnet.fr>,
        mirabilos {Thorsten Glaser} <isch@ecce.homeip.net>,
        "L . K ." <lk@aniela.eu.org>,
        "Albert D . Cahalan" <acahalan@cs.uml.edu>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: Re: temperature standard - global config option?
Message-ID: <20010608145646.D20944@alcove.wittsend.com>
Mail-Followup-To: "J . A . Magallon" <jamagallon@able.es>,
	"Michael H . Warfield" <mhw@wittsend.com>,
	Chris Boot <bootc@worldnet.fr>,
	mirabilos {Thorsten Glaser} <isch@ecce.homeip.net>,
	"L . K ." <lk@aniela.eu.org>,
	"Albert D . Cahalan" <acahalan@cs.uml.edu>,
	"linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20010607212138.B29121@alcove.wittsend.com> <B746D8FA.F994%bootc@worldnet.fr> <20010608140553.C20944@alcove.wittsend.com> <20010608204306.C2768@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <20010608204306.C2768@werewolf.able.es>; from jamagallon@able.es on Fri, Jun 08, 2001 at 08:43:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2001 at 08:43:06PM +0200, J . A . Magallon wrote:

> On 06.08 Michael H. Warfield wrote:

> > 	Actually, the REAL point I was TRYING to make (and doing a really
> > shabby job of it) is that some of this needs a little dose of reality.
> > We don't have sensors that are accurate to 1/10 of a K and certainly not
> > to 1/100 of a K.  Knowing the CPU temperature "precise" to .01 K when
> > the accuracy of the best sensor we are likely to see is no better than
> > +- 1 K is just about as relevant as negative absolute temperatures.

> Lets see, somebody can develop lab equipment (dont think on PTRs or
> thermistors in common world) that givee 10e-3 precission, and you are just
> making linux not suitable to control that hardware. Think open.
> What is the real difference between managing temperatures with a short
> or a long ?. Is it really needed to fit it in a short ??!!!
> I would use an unsigned long with fixed point and all done.

	No, we are not talking lab instrumentation here.  We are talking
about CPU monitoring.  Lab instrumentation is a whole different issue
with things like the IEEE bus and such.  Lab instrumentation would require
it's own drivers and interface.

> -- 
> J.A. Magallon                           #  Let the source be with you...        
> mailto:jamagallon@able.es
> Linux Mandrake release 8.1 (Cooker) for i586
> Linux werewolf 2.4.5-ac9 #1 SMP Wed Jun 6 09:57:46 CEST 2001 i686

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

