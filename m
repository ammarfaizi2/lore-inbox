Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131899AbRDTV0C>; Fri, 20 Apr 2001 17:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131973AbRDTVZp>; Fri, 20 Apr 2001 17:25:45 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:48401 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S131949AbRDTVZc>;
	Fri, 20 Apr 2001 17:25:32 -0400
Date: Fri, 20 Apr 2001 17:24:35 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Nicolas Pitre <nico@cam.org>, Tom Rini <trini@kernel.crashing.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Matthew Wilcox <willy@ldl.fc.hp.com>,
        james rich <james.rich@m.cc.utah.edu>,
        lkml <linux-kernel@vger.kernel.org>, parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] Re: OK, let's try cleaning up another nit. Is anyone paying attention?
Message-ID: <20010420172435.A21252@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	David Woodhouse <dwmw2@infradead.org>, Nicolas Pitre <nico@cam.org>,
	Tom Rini <trini@kernel.crashing.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Matthew Wilcox <willy@ldl.fc.hp.com>,
	james rich <james.rich@m.cc.utah.edu>,
	lkml <linux-kernel@vger.kernel.org>, parisc-linux@parisc-linux.org
In-Reply-To: <Pine.LNX.4.33.0104201440580.12186-100000@xanadu.home> <6817.987801548@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <6817.987801548@redhat.com>; from dwmw2@infradead.org on Fri, Apr 20, 2001 at 10:19:08PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org>:
> > Otherwise how can you distinguish between dead wood which must be
> > removed and potentially valid symbols referring to code existing only
> > in a remote tree?
> 
> By periodically publishing a list of the potentially-obsolete symbols as ESR
> has done, and _not_ removing the ones which people speak up about. It's not
> as if this is something which needs to be done more than about once a year.

Not good enough.  In a year, the pile of false positives would get high enough
to make it too hard to spot real bugs like the Aironet mismatch.  The whole 
point of the cleanup is to be able to mechanize the consistency checks so they
require a minimum of human judgment.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"This country, with its institutions, belongs to the people who
inhabit it. Whenever they shall grow weary of the existing government,
they can exercise their constitutional right of amending it or their
revolutionary right to dismember it or overthrow it."
	-- Abraham Lincoln, 4 April 1861
