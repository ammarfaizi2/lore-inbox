Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131483AbRDPWUq>; Mon, 16 Apr 2001 18:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131625AbRDPWUg>; Mon, 16 Apr 2001 18:20:36 -0400
Received: from spc2.esa.lanl.gov ([128.165.67.191]:5504 "HELO
	spc2.esa.lanl.gov") by vger.kernel.org with SMTP id <S131483AbRDPWU2>;
	Mon, 16 Apr 2001 18:20:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
To: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [kbuild-devel] CML2 1.1.3 is available
Date: Mon, 16 Apr 2001 16:26:29 -0600
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net,
        elenstev@mesatop.com
In-Reply-To: <20010416174223.A21689@thyrsus.com> <01041616003800.01249@spc2.esa.lanl.gov> <20010416180628.A21941@thyrsus.com>
In-Reply-To: <20010416180628.A21941@thyrsus.com>
MIME-Version: 1.0
Message-Id: <01041616262902.01249@spc2.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 April 2001 16:06, Eric S. Raymond wrote:
> Steven Cole <scole@lanl.gov>:
> > Whoops, I just tried out 1.1.3 using make xconfig, and now all the
> > option labels are dark green, not just the ones set to y.
>
> That's because they're set in your .config, dude!

Well, lets look at a snippet of the .config:

# CONFIG_BINFMT_SOM is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
# CONFIG_SMP is not set

I just re-installed CML2 1.1.2, and it shows those options as you would expect,
that is the ones set to y are green, and the "not set" ones are black.  Well, except
CONFIG_BINFMT_ELF which is black.  Toggling it to n and then to y makes it green.

Re-installing CML2 1.1.3, I see all those options as green.

I can send you my whole .config if that would be useful.

Steven
