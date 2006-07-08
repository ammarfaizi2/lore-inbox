Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbWGHRBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWGHRBd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 13:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWGHRBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 13:01:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:53181 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964896AbWGHRBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 13:01:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hr9TaArTX7MYJMBXG18yCReqtZoUuwrkwJaihv/Feoh1IojifpZaA4/Jli05pOG1URv/WOr3tKbpuYaTLo0/d2nv5V9vNTUir53Re8YlExo9dHwOrjtkemNm4lXhf0pE+fvFU8JuiL0UD8BWQ4dG7mp+csFz8ZsN9RHTJvwgyVE=
Message-ID: <9e0cf0bf0607081001x6ccbd080sbe64118965d90838@mail.gmail.com>
Date: Sat, 8 Jul 2006 20:01:30 +0300
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Cc: "Olivier Galibert" <galibert@pobox.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Avuton Olrich" <avuton@gmail.com>, linux-kernel@vger.kernel.org,
       "Jan Rychter" <jan@rychter.com>, suspend2-devel@lists.suspend2.net,
       grundig <grundig@teleline.es>,
       "Nigel Cunningham" <ncunningham@linuxmail.org>
In-Reply-To: <1152377246.3120.65.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060627133321.GB3019@elf.ucw.cz>
	 <20060707215656.GA30353@dspnet.fr.eu.org>
	 <20060707232523.GC1746@elf.ucw.cz>
	 <200607080933.12372.ncunningham@linuxmail.org>
	 <20060708002826.GD1700@elf.ucw.cz>
	 <m2d5cg1mwy.fsf@tnuctip.rychter.com>
	 <1152353698.2555.11.camel@coyote.rexursive.com>
	 <1152355318.3120.26.camel@laptopd505.fenrus.org>
	 <20060708164312.GA36499@dspnet.fr.eu.org>
	 <1152377246.3120.65.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/06, Arjan van de Ven <arjan@infradead.org> wrote:
> Just take the alsa/OSS case. It's taken Adrian Bunk a LOT of effort to
> get people to report bugs against alsa; unless you threaten to remove
> the other driver they just won't and switch to the other driver. On the
> one hand, that is choice. On the other, it's BAD. The user experience is
> BAD. It means we end up with 2 half arsed cases (since the OSS driver
> doesn't do other things) instead of one quite good one.

Well...
OSS->swsusp
ALSA->Suspend2

Merge them both, and see which wins.
Anyway... Unlike the ALSA case, people opens bugs on suspen2 (The new
system) and not on swsusp, since Nigel is much more receptive, and
because of the large user community suspend2 works much better.

Pavel and Refael beg people to open bugs agains swsusp/uswsusp... But
people prefers to solve issues of the out-of-kernel solution...  The
process is as follows:

Try swsusp->It does not work/Not suited->Try suspend2->Works/does
not->Get support from suspend2->Suspend2 works->Suspend2 better->User
happy.

Best Regards,
Alon Bar-Lev.
