Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263716AbREYLau>; Fri, 25 May 2001 07:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263717AbREYLal>; Fri, 25 May 2001 07:30:41 -0400
Received: from 98-CORU-X8.libre.retevision.es ([62.83.53.98]:37272 "HELO
	trasno.mitica") by vger.kernel.org with SMTP id <S263716AbREYLaW>;
	Fri, 25 May 2001 07:30:22 -0400
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
Cc: Hans Reiser <reiser@namesys.com>, Andi Kleen <ak@suse.de>,
        Andreas Dilger <adilger@turbolinux.com>,
        monkeyiq <monkeyiq@users.sourceforge.net>,
        linux-kernel@vger.kernel.org, Nikita Danilov <god@namesys.com>
Subject: Re: Dying disk and filesystem choice.
In-Reply-To: <m3bsoj2zsw.fsf@kloof.cr.au>
	<200105240658.f4O6wEWq031945@webber.adilger.int>
	<20010524103145.A9521@gruyere.muc.suse.de>
	<3B0D3C99.255B5A24@namesys.com>
	<20010524214641.E10968@arthur.ubicom.tudelft.nl>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20010524214641.E10968@arthur.ubicom.tudelft.nl>
Date: 25 May 2001 13:29:09 +0200
Message-ID: <m2r8xdoeey.fsf@trasno.mitica>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "erik" == Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL> writes:

erik> On Thu, May 24, 2001 at 09:53:45AM -0700, Hans Reiser wrote:
>> No, reiserfs does have badblock support!!!!
>> 
>> You just have to get it as a separate patch from us because it was
>> written after code freeze.

erik> IMHO we are not that deep into code freeze anymore. Freevxfs got added
erik> in linux-2.4.5-pre*, so I think that a patch that adds a useful feature
erik> like badblock support would be OK.

A new filesystem don't touch anything if you don't use it.  Some
reasoning for inclusion of new drivers.  Big changes in a working
driver could make it not to work (very bad in the stable series).

Later, Juan.


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
