Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132556AbRDQNwc>; Tue, 17 Apr 2001 09:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132573AbRDQNwX>; Tue, 17 Apr 2001 09:52:23 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:2576 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132556AbRDQNwK>;
	Tue, 17 Apr 2001 09:52:10 -0400
Date: Tue, 17 Apr 2001 09:53:15 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Leif Sawyer <lsawyer@gci.com>
Cc: esr@snark.thyrsus.com, linux-kernel@vger.kernel.org
Subject: Re: CML2 1.1.3 release announcement
Message-ID: <20010417095315.B27468@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Leif Sawyer <lsawyer@gci.com>, esr@snark.thyrsus.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <BF9651D8732ED311A61D00105A9CA3150446DA08@berkeley.gci.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <BF9651D8732ED311A61D00105A9CA3150446DA08@berkeley.gci.com>; from lsawyer@gci.com on Mon, Apr 16, 2001 at 03:46:44PM -0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leif Sawyer <lsawyer@gci.com>:
> It also appears that upon a re-configuration of 2.4.3 from 2.2.17:
> 
> > cd /usr/src/linux
> > cp ../linux-2.2.17/.config .
> > make oldconfig
> 
> where the old configuration did not include FrameBuffer support,
> then performing an Xconfig to tweak some settings and enable FB,
> no default fonts were allocated.  This is contrary to CML1 behavoir.
> 
> > grep ^CONFIG_FB .config
> CONFIG_FB=y
> CONFIG_FB_VESA=y
> CONFIG_FB_MACH64=y
> 
> 
> however CML1, after only selecting the applicable drivers gives:
> > grep ^CONFIG_FB ~/myotherbox-2.4.3.config
> CONFIG_FB=y
> CONFIG_FB_VESA=y
> CONFIG_FB_VGA16=y
> CONFIG_FBCON_CFB8=y
> CONFIG_FBCON_CFB16=y
> CONFIG_FBCON_CFB24=y
> CONFIG_FBCON_CFB32=y
> CONFIG_FBCON_VGA_PLANES=y

Yes, all those extra symbols are derived from the drivers that you 
didn't select during the CML2 run.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

.. a government and its agents are under no general duty to 
provide public services, such as police protection, to any 
particular individual citizen...
        -- Warren v. District of Columbia, 444 A.2d 1 (D.C. App.181)
