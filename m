Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285007AbRLQF2e>; Mon, 17 Dec 2001 00:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285014AbRLQF2Y>; Mon, 17 Dec 2001 00:28:24 -0500
Received: from arsenal.visi.net ([206.246.194.60]:40337 "EHLO visi.net")
	by vger.kernel.org with ESMTP id <S285007AbRLQF2Q>;
	Mon, 17 Dec 2001 00:28:16 -0500
Date: Mon, 17 Dec 2001 00:28:12 -0500
From: Ben Collins <bcollins@debian.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.11 is available
Message-ID: <20011217002812.A377@blimpo.internal.net>
In-Reply-To: <4738.1008565495@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4738.1008565495@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 04:04:55PM +1100, Keith Owens wrote:
> 
> The sparc support is against Linus's 2.4.16 kernel, not against the
> vger tree, the latter is moving too fast.  I expect that some tweaking
> will be required for the vger sparc changes, in particular the removal
> of config options for netlink.  Release 1.11 does not contain any
> changes to the sparc patches, use the release 1.10 patches for sparc.
> 

If anyone needs them, I can provide a small diff for the sparc/sparc64
Vger CVS changes to apply on top of the main kbuild-2.5 patch. Very
minor change (hint, in Vger, netlink is compiled unconditionally now).


Ben

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
