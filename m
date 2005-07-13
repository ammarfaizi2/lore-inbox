Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262522AbVGMCoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbVGMCoV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 22:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262919AbVGMCoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 22:44:21 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:5388 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S262522AbVGMCoQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 22:44:16 -0400
Message-ID: <42D48DCC.2020906@slaphack.com>
Date: Tue, 12 Jul 2005 22:43:08 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
To: Hans Reiser <reiser@namesys.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Stefan Smietanowski <stesmi@stesmi.com>, Hubert Chan <hubert@uhoreg.ca>,
       Ross Biro <ross.biro@gmail.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: reiser4 plugins
References: <200507120233.j6C2XODw030361@laptop11.inf.utfsm.cl> <42D35AE4.9000400@namesys.com> <42D450BE.70404@slaphack.com> <42D45464.2090308@namesys.com>
In-Reply-To: <42D45464.2090308@namesys.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> David Masover wrote:
> 
> 
>>That's why we're trying to find something that people won't actually
>>touch, especially since if we design it right, this will be the last
>>delimiter introduced at the fs/vfs level.
> 
> 
> Uh, no, there needs to be about a dozen or so more.

Where?

 From what I (vaguely) remember of the future-vision paper, having the 
meta delimiter lets us do everything else from inside the metas.  We can 
certainly add delimiters to stuff in a meta-dir...


-- 
No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.323 / Virus Database: 267.8.12/46 - Release Date: 7/11/2005

