Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288861AbSAEQ1Z>; Sat, 5 Jan 2002 11:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288860AbSAEQ1P>; Sat, 5 Jan 2002 11:27:15 -0500
Received: from arsenal.visi.net ([206.246.194.60]:18336 "EHLO visi.net")
	by vger.kernel.org with ESMTP id <S288858AbSAEQ1E>;
	Sat, 5 Jan 2002 11:27:04 -0500
Date: Sat, 5 Jan 2002 11:27:00 -0500
From: Ben Collins <bcollins@debian.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: andreas.bombe@munich.netsurf.de, linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.2-pre8/drivers/ieee1394 kdev_t compilation fixes
Message-ID: <20020105162700.GB14634@blimpo.internal.net>
In-Reply-To: <20020104234128.A26076@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020104234128.A26076@baldur.yggdrasil.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 11:41:28PM -0800, Adam J. Richter wrote:
> 	The following patch fixes the kdev_t compilation errors
> in linux-2.5.2-pre8/drivers/ieee1394.  It just a global replace
> of "MINOR(" with "minor(".  I only know that the new code compiles.
> I have not tested it.

I'll get this checked into CVS today. I planned on a sync with Linus
soon anyway.

Andreas, now would be a good time for us to branch 2.2.x support in CVS
to simplify 2.4.x/2.5.x compatibility.

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
