Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268368AbUIBOhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268368AbUIBOhP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 10:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268360AbUIBOhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 10:37:15 -0400
Received: from ihemail2.lucent.com ([192.11.222.163]:11933 "EHLO
	ihemail2.lucent.com") by vger.kernel.org with ESMTP id S268353AbUIBOhL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 10:37:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16695.12190.58678.877396@gargle.gargle.HOWL>
Date: Thu, 2 Sep 2004 10:35:10 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: V13 <v13@priest.com>
Cc: Spam <spam@tnonline.net>, Hans Reiser <reiser@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>, David Masover <ninja@slaphack.com>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
In-Reply-To: <200409021327.22998.v13@priest.com>
References: <20040826150202.GE5733@mail.shareable.org>
	<4136E0B6.4000705@namesys.com>
	<1117111836.20040902115249@tnonline.net>
	<200409021327.22998.v13@priest.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


V13> I believe you mean something simillar to: 

V13> file1.txt;1
V13> file1.txt;2
V13> file1.txt;3 (yeap, it's VMS) 

Or TOPS-20, a precursor to VMS in some ways.  It was a nice feature.

V13> where you'll have to cleanup old versions when you don't need
V13> them any more...  AFAIK that this is older than HDDs

It was usually an automatic cleanup past a certain point or if you
went over disk quota.  

In any case, while I do like this feature, I'm not sure how we would
cleanly implement this inside the unix namespace, or if inside a new
namespace, how that new namespace would be joined with a standard Unix
one.

John
