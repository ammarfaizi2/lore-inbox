Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132866AbRDUTyy>; Sat, 21 Apr 2001 15:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132869AbRDUTyo>; Sat, 21 Apr 2001 15:54:44 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:12051 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132870AbRDUTye>;
	Sat, 21 Apr 2001 15:54:34 -0400
Date: Sat, 21 Apr 2001 15:55:09 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: "Giacomo A. Catenazzi" <cate@dplanet.ch>
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Request for comment -- a better attribution system
Message-ID: <20010421155509.B4185@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	"Giacomo A. Catenazzi" <cate@dplanet.ch>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010421114942.A26415@thyrsus.com> <3AE1E77C.AF1402F4@dplanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AE1E77C.AF1402F4@dplanet.ch>; from cate@dplanet.ch on Sat, Apr 21, 2001 at 10:03:08PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo A. Catenazzi <cate@dplanet.ch>:
> We should use the same filed name of CREDITS e.g. D: for Description.
> (maybe you can invert D: description and T: time of last update)

Good point.
 
> It whould nice also if we include the type of the license (GPL,...).
> This for a fast parsing (and maybe also to replace the few lines
> of license)

Is there any kernel code that isn't GPLed?

> Instead of C: it is more important (IMHO) to include the module name.

That we get from the name of the file we're visiting, I think.

> Maybe we can include both (modules name are always lower case).
> I think that the inclusion of the config option is not important (
> considering that it can be easily parsed from the kaos' new makefiles).

Interesting point.  Maybe that field should drop out once we transition.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

A right is not what someone gives you; it's what no one can take from you. 
	-- Ramsey Clark
