Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288008AbSABXk5>; Wed, 2 Jan 2002 18:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288021AbSABXjd>; Wed, 2 Jan 2002 18:39:33 -0500
Received: from gate.mesa.nl ([194.151.5.70]:62475 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id <S287973AbSABXif>;
	Wed, 2 Jan 2002 18:38:35 -0500
Date: Thu, 3 Jan 2002 00:38:02 +0100
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Keith Owens <kaos@ocs.com.au>, timothy.covell@ashavan.org,
        adrian kok <adriankok2000@yahoo.com.hk>, linux-kernel@vger.kernel.org
Subject: Re: system.map
Message-ID: <20020103003802.A15071@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
In-Reply-To: <10236.1010007095@ocs3.intra.ocs.com.au> <200201022223.g02MNrF371382@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201022223.g02MNrF371382@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Wed, Jan 02, 2002 at 05:23:53PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 05:23:53PM -0500, Albert D. Cahalan wrote:
> Keith Owens writes:
> 
> > System.map is not required for booting, it is only used after init
> > starts, therefore it does not belong in /boot anyway.
> 
> It's not about modules either. :-) If you can ignore the
> name, I can too. So "/boot" means "kernel stuff".
 
So I moved /lib/modules in /boot and symlinked /lib/modules -> /boot/modules.
Everything about kernels is then in /boot (partition). This allow me
to share /boot over all the distros I installed and enjoy one kernel
compilation on all distros...

-Marcel


-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
