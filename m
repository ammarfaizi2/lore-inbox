Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313256AbSDDQow>; Thu, 4 Apr 2002 11:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313258AbSDDQon>; Thu, 4 Apr 2002 11:44:43 -0500
Received: from ns.suse.de ([213.95.15.193]:3342 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313256AbSDDQof>;
	Thu, 4 Apr 2002 11:44:35 -0500
Date: Thu, 4 Apr 2002 18:44:33 +0200
From: Dave Jones <davej@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.8-pre1 binutils-related regression on x86
Message-ID: <20020404184433.B11833@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Mikael Pettersson <mikpe@csd.uu.se>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <200204041633.SAA10837@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 06:33:24PM +0200, Mikael Pettersson wrote:

 > -	lcall	*%cs:realmode_swtch
 > +	lcall	%cs:realmode_swtch
 >  
 >  	jmp	rmodeswtch_end
 >  
 > The "*" was put there early in the 2.5 series, to allow non-
 > antique binutils to assemble the code cleanly without warnings.
 > This patch reintroduces those warnings. Uncool.

GAR!, my bad.  Most of the silly bits seem to stem from early 2.5
merges, hopefully there's not too many more sillies.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
