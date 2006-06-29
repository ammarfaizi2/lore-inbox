Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932917AbWF2Vpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932917AbWF2Vpo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWF2Vpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:45:42 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:60682 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932912AbWF2Voa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:30 -0400
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>, torvalds@osdl.org,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>,
       Chuck Wolber <chuckw@quantumlinux.com>, Sam Ravnborg <sam@ravnborg.org>,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] [PATCH 21/25] kbuild: Fix 100% initramfs bloat in 2.6.17 versus 2.6.16
References: <20060627200745.771284000@sous-sol.org>
	<20060627201655.873643000@sous-sol.org>
	<20060629213402.GB11588@sequoia.sous-sol.org>
From: Nix <nix@esperi.org.uk>
X-Emacs: (setq software-quality (/ 1 number-of-authors))
Date: Thu, 29 Jun 2006 22:43:06 +0100
In-Reply-To: <20060629213402.GB11588@sequoia.sous-sol.org> (Chris Wright's message of "Thu, 29 Jun 2006 14:34:02 -0700")
Message-ID: <87u063zlhx.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006, Chris Wright moaned:
> * Chris Wright (chrisw@sous-sol.org) wrote:
>> -stable review patch.  If anyone has any objections, please let us know.
>> ------------------
>> From: Nix <nix@esperi.org.uk>
>> 
>> When I built 2.6.17 for the first time I was a little surprised to see
>> my kernel putting on >500Kb in weight.
>> 
>> It didn't take long to work out that this was because my initramfs's
>> contents were being included twice in the cpio image.
> 
> Sam accidentally sent the wrong patch, here's variant that went into
> Linus' tree.

A difference that makes no difference is no difference :)

-- 
`She *is*, however, one of the few sf authors with a last name ending in O,
 which adds some extra appeal to those of us who obsess about things like
 having a book review of an author for each letter in the alphabet.' -- rra
