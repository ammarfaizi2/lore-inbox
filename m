Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289362AbSAVTPb>; Tue, 22 Jan 2002 14:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289360AbSAVTPU>; Tue, 22 Jan 2002 14:15:20 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:59048
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289357AbSAVTPN>; Tue, 22 Jan 2002 14:15:13 -0500
Date: Tue, 22 Jan 2002 13:57:14 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Cc: Dave Jones <davej@suse.de>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Calling EISA experts
Message-ID: <20020122135714.A10908@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Paul Gortmaker <p_gortmaker@yahoo.com>, Dave Jones <davej@suse.de>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020117015456.A628@thyrsus.com> <20020117121723.B22171@suse.de> <3C46B718.26F52BD5@mandrakesoft.com> <20020117124849.F22171@suse.de> <20020117085056.B7299@thyrsus.com> <3C4C0056.4F50C3D6@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C4C0056.4F50C3D6@yahoo.com>; from p_gortmaker@yahoo.com on Mon, Jan 21, 2002 at 06:49:42AM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Gortmaker <p_gortmaker@yahoo.com>:
> Minimal approach: Register motherboard EISA ID (i.e. slot zero) ports in
> /proc/ioports.  Works on all kernel versions.  See $0.02 patch below.
> 
> This is probably the least intrusive way to get what you want.  It doesn't
> add Yet Another Proc File, and costs zero bloat to the 99.9% of us who 
> have a better chance of meeting Aunt Tillie than an EISA box. 

Yup.  This is the first, and so far the only, C-level kernel patch that
I've added to the CML2 kit.
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
