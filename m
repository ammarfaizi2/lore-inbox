Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVCCFb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVCCFb5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 00:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVCCFX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 00:23:57 -0500
Received: from mail.autoweb.net ([198.172.237.26]:19984 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261484AbVCCFUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 00:20:34 -0500
Date: Thu, 3 Mar 2005 00:20:21 -0500
From: Ryan Anderson <ryan@michonline.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11
Message-ID: <20050303052021.GK7828@mythryan2.michonline.com>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Matthias Andree <matthias.andree@gmx.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0503012356480.25732@ppc970.osdl.org> <20050302103158.GA13485@merlin.emma.line.org> <Pine.LNX.4.58.0503020738300.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503020738300.25732@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 07:46:05AM -0800, Linus Torvalds wrote:
> (In contrast the full ChangeLog was missing because the generation script
> I use is not exactly the smart way, so it's O(slow(n)), where slow is n**3 
> or worse, so the log from the last -rc release is fast, but going back all 
> the way to 2.6.10 took long long enough that I didn't wait for it).

Is there some reason why
	bk changes -aem -rv2.6.10..+ | shortlog
isn't sufficient?

I'd guess your script will want to calculate the 2.6.10 part
automatically, but that seems to run in a second or so on my machine,
from a largely cold cache.  I *think* this gets all the changes where a
-d (date) based method gets very confused by parallel trees.  Am I
missing something?

-- 

Ryan Anderson
  sometimes Pug Majere
