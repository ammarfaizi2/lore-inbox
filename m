Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264219AbRFHSHj>; Fri, 8 Jun 2001 14:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264308AbRFHSHT>; Fri, 8 Jun 2001 14:07:19 -0400
Received: from alcove.wittsend.com ([130.205.0.20]:49811 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S264303AbRFHSHS>; Fri, 8 Jun 2001 14:07:18 -0400
Date: Fri, 8 Jun 2001 14:05:53 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Chris Boot <bootc@worldnet.fr>
Cc: "Michael H. Warfield" <mhw@wittsend.com>,
        mirabilos {Thorsten Glaser} <isch@ecce.homeip.net>,
        "L. K." <lk@aniela.eu.org>, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: temperature standard - global config option?
Message-ID: <20010608140553.C20944@alcove.wittsend.com>
Mail-Followup-To: Chris Boot <bootc@worldnet.fr>,
	"Michael H. Warfield" <mhw@wittsend.com>,
	mirabilos {Thorsten Glaser} <isch@ecce.homeip.net>,
	"L. K." <lk@aniela.eu.org>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20010607212138.B29121@alcove.wittsend.com> <B746D8FA.F994%bootc@worldnet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <B746D8FA.F994%bootc@worldnet.fr>; from bootc@worldnet.fr on Fri, Jun 08, 2001 at 07:33:14PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2001 at 07:33:14PM +0200, Chris Boot wrote:
> Hi,

> > Then you must have blown your quantum finals.  Royally.  ESPECIALLY
> > after that statement about "temperature is nothing but the movement of
> > pieces of materie".  Not even close, once you get into the quant.
> > 
> > Mathematically and quantum mechanically, negative absolute
> > temperatures do exist.  In quantum mechanics, temperature is expressed as
> > probability populations in various quantum states.

> Excuse me, but I don't think that we can get computer temperature sensors as
> we know them to measure temperatures of matter in quantum states.  Even if,
> one day, we built a usable quantum computer which might need temperature
> measurements, I doubt that the Linux kernel would run on it without being
> totally rewritten.

> Anyhow, I like the discussion.  I love anything to do with quantum physics!

	Actually, the REAL point I was TRYING to make (and doing a really
shabby job of it) is that some of this needs a little dose of reality.
We don't have sensors that are accurate to 1/10 of a K and certainly not
to 1/100 of a K.  Knowing the CPU temperature "precise" to .01 K when
the accuracy of the best sensor we are likely to see is no better than
+- 1 K is just about as relevant as negative absolute temperatures.
(Ok...  Ok...  Actually it did annoy me, as someone who majored in
physics, to see someone else write that because physics was "a major
course" for them that they could say definitively that there was no such
thing and that temperature was only the movement of materials.  But it
was a perfect opening to try an exercise in absurdity.  It just seems to
have flopped.  My fault.)

	Trying to keep this relevant to the topic of the Linux kernel,
I was trying to impress people with the absurdity.  That's why I closed
that message about the precision being just as silly.  Unfortunately,
I need to be a little more explicit about things like that since it
seems that my forey into absurdity went right over several peoples heads.
Again...  My fault.

	Even if we had or could, anticiplate, sensors with a +- .01 K,
the relevance of knowing the CPU temperature to that precision is
lost on me.  I see no sense in stuffing a field with meaningless
bits just because the field will hold them.  In fact, this "false precision"
quickly leads to the false impression of accuracy.  Based on several
messages I have seen on this thread and in private E-Mail, there are a
number of people who don't seem to grasp the fundamental difference
between precision and accuracy and truely don't understand that adding
meaningless precision like this adds nothing to the accuracy.

	I can see maybe making it precise to .1 K.  But stuffing the bits
in there to be precise to .01 K just because we have the bits and not
because we have any realistic information to fill the bits in with, is
just silly to me.  Just as silly as allowing for negative numbers in an
absolute temperature field.  We have the bits to support it, but why?

	I do agree that it should be in K, though.

> -- 
> Chris Boot
> bootc@worldnet.fr

> #define QUESTION ((2b) || (!2b))

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

