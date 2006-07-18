Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWGRQnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWGRQnm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 12:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWGRQnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 12:43:42 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:35020 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751366AbWGRQnl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 12:43:41 -0400
Date: Tue, 18 Jul 2006 18:38:10 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Hans Reiser <reiser@namesys.com>
cc: Jeff Mahoney <jeffm@suse.com>, 7eggert@gmx.de,
       Eric Dumazet <dada1@cosmosbay.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
In-Reply-To: <44BBFB0D.6040105@namesys.com>
Message-ID: <Pine.LNX.4.61.0607181835020.24589@yvahk01.tjqt.qr>
References: <6xQ4C-6NB-43@gated-at.bofh.it> <6xQea-6ZX-13@gated-at.bofh.it>
 <E1G1QFx-0001IO-K6@be1.lrz> <44B7D97B.20708@suse.com> <44B9E6D5.2040704@namesys.com>
 <44BA61A2.5090404@suse.com> <44BA8214.7040005@namesys.com> <44BABB14.6070906@suse.com>
 <44BAE619.9010307@namesys.com> <44BAECE2.8070301@suse.com> <44BAFDC3.7020301@namesys.com>
 <44BB0146.7080702@suse.com> <44BB3C42.1060309@namesys.com> <44BBA4CF.8020901@suse.com>
 <44BBD4B6.5020801@namesys.com> <44BBD942.3080908@suse.com> <44BBDFFC.70601@namesys.com>
 <44BBEC17.8020507@suse.com> <44BBFB0D.6040105@namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Try v4.
>
>> My original xattr
>> implementation added another item type, but oh -- wait -- it turns out
>> that the file system isn't quite as extensible as claimed.. or, well, AT
>> ALL. Adding another item results in an incompatible file system change
>> that when mounted on another system, will panic the node. That's
>> friendly! There's not even any way to identify which items are in use on
>> a particular file system to issue a warning/error on mount. Outstanding
>> job "architecting" there.
>
>Well, if you had an obsessive desire to not use V4, you could fix this
>in V3 instead.
>
>Might be easier to use V4...
>
>> Users
>> wanted ACLs and xattrs on reiser3, but you said, "wait for v4, it'll be
>> out soon, and it'll have them." That was 4 years ago. Reiser4 still
>> isn't completely stable 

My word here is done:

While reiserfs3 actually got ACLs, xattrs and quota support by now, reiser4
still lacks them. Something must be very wrong to suggest V4; at least when it
comes to these three things.


Jan Engelhardt
-- 
