Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288278AbSAHTtw>; Tue, 8 Jan 2002 14:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288276AbSAHTtm>; Tue, 8 Jan 2002 14:49:42 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:57740
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288274AbSAHTta>; Tue, 8 Jan 2002 14:49:30 -0500
Date: Tue, 8 Jan 2002 14:33:12 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: Russell King <rmk@arm.linux.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: Missing entries in Configuure.help)
Message-ID: <20020108143312.A27085@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	"Dr. David Alan Gilbert" <gilbertd@treblig.org>,
	Russell King <rmk@arm.linux.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.arm.linux.org.uk
In-Reply-To: <20020106210233.A30319@thyrsus.com> <20020107085307.A17914@flint.arm.linux.org.uk> <20020108124334.A24742@thyrsus.com> <20020108193503.GA852@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020108193503.GA852@gallifrey>; from gilbertd@treblig.org on Tue, Jan 08, 2002 at 07:35:03PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dr. David Alan Gilbert <gilbertd@treblig.org>:
> * Eric S. Raymond (esr@thyrsus.com) wrote:
> 
> > CPU_ARM922_D_CACHE_ON
> > CPU_ARM922_I_CACHE_ON
> > CPU_ARM922_WRITETHROUGH
> 
> Hmm - is there anything ARM922 specific about these - i.e. is there a
> reason that we shouldn't get rid of them and have some architecture
> independent symbols CPU_D_CACHE_ON, CPU_I_CACHE_ON and
> CPU_CACHE_WRITETHROUGH (and more to your taste) and then architectures
> can use the ones which apply to them.
> 
> Doesn't seem to be a point in having dupes.

I agree. I think there are now no fewer than four parallel sets of these.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"This country, with its institutions, belongs to the people who inhabit it. 
Whenever they shall grow weary of the existing government, they can exercise
their constitutional right of amending it or their revolutionary right to 
dismember it or overthrow it."	-- Abraham Lincoln, 4 April 1861
