Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132701AbRECP6c>; Thu, 3 May 2001 11:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132806AbRECP6W>; Thu, 3 May 2001 11:58:22 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:44296 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132701AbRECP6K>;
	Thu, 3 May 2001 11:58:10 -0400
Date: Thu, 3 May 2001 11:58:48 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: David Mansfield <lkml@dm.ultramaster.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Why recovering from broken configs is too hard
Message-ID: <20010503115848.F31960@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	David Mansfield <lkml@dm.ultramaster.com>,
	Alexander Viro <viro@math.psu.edu>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010503104511.C754@nightmaster.csn.tu-chemnitz.de> <Pine.GSO.4.21.0105030452310.15957-100000@weyl.math.psu.edu> <20010503054349.C28728@thyrsus.com> <3AF17135.F52C889D@dm.ultramaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AF17135.F52C889D@dm.ultramaster.com>; from lkml@dm.ultramaster.com on Thu, May 03, 2001 at 10:54:45AM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mansfield <lkml@dm.ultramaster.com>:
> If so, given the above ruleset involving symbols A, B and C, and given
> that such a ruleset is violated for some reason (you don't even care
> why), use the following approach:
> 
> set C to 'n' -> are we ok?
> set B to 'n' -> are we ok?
> set A to 'n' -> are we ok?
> 
> Inform the user of each change.  In a massively broken configuration you
> could end up with a lot of stuff set to 'n' ultimately, but I think that
> this generally would just end up shutting off troublesome configuration
> settings, and requiring that the user then reset them manually.

Actually this is the best idea I've seen yet, because the single "known-good"
configuration is almost all n values.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Let us hope our weapons are never needed --but do not forget what 
the common people knew when they demanded the Bill of Rights: An 
armed citizenry is the first defense, the best defense, and the 
final defense against tyranny.
   If guns are outlawed, only the government will have guns. Only 
the police, the secret police, the military, the hired servants of 
our rulers.  Only the government -- and a few outlaws.  I intend to 
be among the outlaws.
        -- Edward Abbey, "Abbey's Road", 1979
