Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWHAPdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWHAPdf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 11:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbWHAPde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 11:33:34 -0400
Received: from aben100.neoplus.adsl.tpnet.pl ([83.7.25.100]:35258 "EHLO
	pcserwis") by vger.kernel.org with ESMTP id S932116AbWHAPdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 11:33:33 -0400
Date: Tue, 01 Aug 2006 17:32:52 +0200
To: "Linus Torvalds" <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: metadata plugins (was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion)
From: =?iso-8859-2?B?o3VrYXN6IE1pZXJ6d2E=?= <prymitive@pcserwis.hopto.org>
Organization: PC Serwis
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-2
MIME-Version: 1.0
References: <200607281402.k6SE245v004715@laptop13.inf.utfsm.cl> <44CA31D2.70203@slaphack.com> <Pine.LNX.4.64.0607280859380.4168@g5.osdl.org>
Content-Transfer-Encoding: 8bit
Message-ID: <op.tdl2s2fpd4os1z@localhost>
In-Reply-To: <Pine.LNX.4.64.0607280859380.4168@g5.osdl.org>
User-Agent: Opera Mail/9.00 (Linux)
X-PCSerwis-MailScanner-Information: Please contact the ISP for more information
X-PCSerwis-MailScanner: Found to be clean
X-PCSerwis-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-15.262, required 6, autolearn=not spam, ALL_TRUSTED -1.80,
	AWL 1.54, BAYES_00 -15.00)
X-MailScanner-From: prymitive@pcserwis.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Fri, 28 Jul 2006 18:33:56 +0200, Linus Torvalds <torvalds@osdl.org>  
napisa³:

> In other words, if a filesystem wants to do something fancy, it needs to
> do so WITH THE VFS LAYER, not as some plugin architecture of its own. We
> already have exactly the plugin interface we need, and it literally _is_
> the VFS interfaces - you can plug in your own filesystems with
> "register_filesystem()", which in turn indirectly allows you to plug in
> your per-file and per-directory operations for things like lookup etc.

What fancy (beside cryptocompress) does reiser4 do now?
Can someone point me to a list of things that are required by kernel  
mainteiners to merge reiser4 into vanilla?
I feel like I'm getting lost with current reiser4 status and things that  
are need to be done.

£ukasz Mierzwa
