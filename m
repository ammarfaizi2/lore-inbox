Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbTE0A13 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 20:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbTE0A13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 20:27:29 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6860
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262410AbTE0A12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 20:27:28 -0400
Subject: Re: [patch?] truncate and timestamps
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
       akpm@digeo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030523011751.GC14406@parcelfarce.linux.theplanet.co.uk>
References: <UTC200305230017.h4N0Hqn05589.aeb@smtp.cwi.nl>
	 <Pine.LNX.4.44.0305221726300.19226-100000@home.transmeta.com>
	 <20030523011751.GC14406@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053992553.17151.18.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 May 2003 00:42:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-05-23 at 02:17, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> Andries had shown that there is _no_ consensus.  Ergo, POSIX can take
> a hike and we should go with the behaviour convenient for us.  It's that
> simple...

Skipping the update on a truncate not changing size is a performance win
although not a very useful one. I don't think we can ignore the standard
however. For one it simply means all the vendors have to fix it so they
can sell to Government etc. 

Now we can certainly put the fix in -every- vendor tree on the planet
and not base, I'm just not sure for something so trivial it isnt better
just to fix it to the spec *or* beat the spec authors up to fix the
spec.

