Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287025AbRL1UzK>; Fri, 28 Dec 2001 15:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287021AbRL1UzA>; Fri, 28 Dec 2001 15:55:00 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:18394
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S287008AbRL1Uyn>; Fri, 28 Dec 2001 15:54:43 -0500
Date: Fri, 28 Dec 2001 15:39:02 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011228153902.B17774@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011228141211.B15338@thyrsus.com> <Pine.GSO.4.21.0112281459380.3924-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0112281459380.3924-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Dec 28, 2001 at 03:26:32PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu>:
> > I think this is an issue that is rising in importance.  I have no problem
> > with assuming that kernel hackers are English-literate, but it's no longer
> > an assumption we should make about people *building* kernels.  I want
> > to encourage CML2 and question-string localizations for French.  And
> > German.  And Thai.  And Ethiopian.
> 
> You are nuts.  OK, you've got these translations.  Now what?  $FOO adds
> a new option.  Should he, by any chance, supply all relevant translations
> in the same patch?  No?

No.  The usual way to handle this, of course, is to fall back on the English
where you don't have translations.  Imperfect, but liveable.

>                       Good, so we are going to have them permanently
> out of sync.  Better yet, option changes its meaning.  Now we have
> English variant with new semantics and Thai one with the old.  Happy,
> happy, joy, joy...

Which is why there are organized translation groups that do periodic
translation updates for software that has registered with them.  This
doesn't eliminate the problem, but it can keep it within manageable bounds
that make having localizations better than not.  I deal with this regularly
with respect to fetchmail.

Anyway, options change semantics only very rarely in the kernel rulebase.
Trust me on this as I've been maintaining the CML2 rulebase for 18 months;
I have a better handle on the frequency of these events than *anyone* else.
You are worrying about a non-problem in this case.

> And that's aside of the real problem with "internationalization" - quality
> of translations _sucks_.  Always.

No, not always.  I read French, Italian, and Spanish; I can puzzle out
technical prose in a couple of other languages.  I can read
fetchmail's .po files and *see* that they don't suck.  

> Frankly, I find it very amusing that advocates of i18n efforts tend to
> be either British or USAnians.

That's not my experience.  I've had technical problems with GNU
gettext (unrelated to quality of translation) severe enough that I've
come very close to dropping localization support twice.  The people
who plead with me not to drop it have been non-Anglophones.

It may be that the reason our experiences have been different is because we 
focus on different target languages.  But I think my experience is an
existence proof that there *is* demand for localization and that meeting
it can have useful results.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

I do not find in orthodox Christianity one redeeming feature.
	-- Thomas Jefferson
