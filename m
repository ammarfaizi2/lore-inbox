Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVFAPLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVFAPLu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVFAPJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:09:44 -0400
Received: from main.gmane.org ([80.91.229.2]:18351 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261417AbVFAPIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:08:19 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: 2.6.12-rc5-mm2
Date: Wed, 01 Jun 2005 17:04:54 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.06.01.15.04.49.64662@smurf.noris.de>
References: <20050601022824.33c8206e.akpm@osdl.org> <20050601140233.GD1940@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Pavel Machek wrote:

> Hi!
> 
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc5/2.6.12-rc5-mm2/
>> 
>> 
>> - Dropped bk-acpi.patch.  Too old, too much breakage.
>> 
>> - A few more subsystem trees have moved to using git
> 
> Have you considered publishing -mm using git?
> 
> I guess your workflow prevents you from really using git, but even just
> publishing releases using git would be great.
> 
> (Just now I'm tracking Linus with my tree.  git makes that quite easy.
> Tracking -mm is ugly manual work with diff, patch and ketchup...)

I have written a script (actually a leftover from the mm-to-BK import
days) that pulls -mm into git as individual commits.

Andrew: Could you prefix the patches you pull from git with this
line:

GIT SHA1-of-their-top-commit URL-of-their-archive

so that I can annotate the commits with an appropriate second parent?

If you never do any changes oon top of -mm, but only merge with it (or
them), then this works out quite well.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Andrea: Unhappy the land that has no heroes.
Galileo: No, unhappy the land that _____needs heroes.
		-- Bertolt Brecht, "Life of Galileo"


