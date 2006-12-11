Return-Path: <linux-kernel-owner+w=401wt.eu-S1763074AbWLKUYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763074AbWLKUYT (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 15:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763073AbWLKUYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 15:24:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48272 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762953AbWLKUYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 15:24:18 -0500
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
From: Arjan van de Ven <arjan@infradead.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Andy Whitcroft <apw@shadowen.org>, Linus Torvalds <torvalds@osdl.org>,
       Herbert Poetzl <herbert@13thfloor.at>, Olaf Hering <olaf@aepfle.de>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
In-Reply-To: <20061211201552.GB20960@thunk.org>
References: <457D750C.9060807@shadowen.org>
	 <20061211163333.GA17947@aepfle.de>
	 <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org>
	 <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org>
	 <20061211180414.GA18833@aepfle.de> <20061211181813.GB18963@aepfle.de>
	 <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org>
	 <20061211182908.GC7256@MAIL.13thfloor.at>
	 <Pine.LNX.4.64.0612111040160.12500@woody.osdl.org>
	 <457DAF99.4050106@shadowen.org>  <20061211201552.GB20960@thunk.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 11 Dec 2006 21:23:32 +0100
Message-Id: <1165868612.27217.434.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> As far as whether or not it should be _mandatory_, to be able to pull
> out the version information from an arbitrary bzImage file, can folks
> agree that it would at least be a nice-to-have feature?  

I would really like for modinfo to work. it may not work on bzImage as
is, but it should work after gunzipping it... and it's the standard way
of conveying all this kind of info anyway

