Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVCCMbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVCCMbB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 07:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVCCMXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 07:23:32 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:4494 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261169AbVCCMWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 07:22:03 -0500
Date: Thu, 3 Mar 2005 13:21:56 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>,
       Matthias Andree <matthias.andree@gmx.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11
Message-ID: <20050303122156.GA25860@merlin.emma.line.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0503012356480.25732@ppc970.osdl.org> <20050302103158.GA13485@merlin.emma.line.org> <Pine.LNX.4.58.0503020738300.25732@ppc970.osdl.org> <20050303052021.GK7828@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303052021.GK7828@mythryan2.michonline.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Anderson schrieb am 2005-03-03:

> Is there some reason why
> 	bk changes -aem -rv2.6.10..+ | shortlog
> isn't sufficient?

For some reason, this omits some changes, perhaps from sibling branches,
I haven't checked.

A similar change however warrants for a huge speedup of the changelog
script, using bk changes rather than bk prs, without affection output at
all. I have made such a change and committed it to my BK copy, see the
"shortlog" announcement I posted two minutes ago.

-- 
Matthias Andree
