Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274971AbTHLCEd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 22:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274972AbTHLCEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 22:04:33 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:12966 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S274971AbTHLCEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 22:04:32 -0400
Date: Tue, 12 Aug 2003 12:02:26 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Cc: kernel-janitor-discuss@lists.sourceforge.net
Subject: C99 Initialisers
Message-ID: <20030812020226.GA4688@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any interest ins omeone 'fixing up' as many structs in the
kernel from the form:

struct foobar = {
	cow:	moo,
	cat:	meow,
}

to:

struct foobar = {
	.cow	= moo,
	.cat	= neow,
}

And if so, what form should I feed it back in? Big patches? 1 patch
per file? 1 per dir?

Main reaosn I'm asking is that it's slowly being done but isn't in
the janitor list of things to do yet. If it were I'd just do it. ;)

(not on kj-discuss btw so please CC me or lk (or both))

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://tinyurl.com/h6fo
