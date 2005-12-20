Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVLTBY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVLTBY1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 20:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbVLTBY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 20:24:27 -0500
Received: from smtp.terra.es ([213.4.129.129]:27365 "EHLO tsmtp3.ldap.isp")
	by vger.kernel.org with ESMTP id S1750728AbVLTBY0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 20:24:26 -0500
Date: Tue, 20 Dec 2005 02:24:16 +0100
From: "Tue, 20 Dec 2005 02:24:16 +0100" <grundig@teleline.es>
To: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
Cc: kernel-stuff@comcast.net, helge.hafting@aitel.hist.no, ak@suse.de,
       bunk@stusta.de, mrmacman_g4@mac.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-Id: <20051220022416.807119d1.grundig@teleline.es>
In-Reply-To: <1135024498.10933.13.camel@localhost>
References: <20051215212447.GR23349@stusta.de>
	<20051215140013.7d4ffd5b.akpm@osdl.org>
	<20051216141002.2b54e87d.diegocg@gmail.com>
	<20051216140425.GY23349@stusta.de>
	<20051216163503.289d491e.diegocg@gmail.com>
	<632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com>
	<p73slsrehzs.fsf@verdi.suse.de>
	<20051217205238.GR23349@stusta.de>
	<61D4A300-4967-4DC1-AD2C-765A3D2D9743@comcast.net>
	<20051218054323.GF23384@wotan.suse.de>
	<5DB2F520-5666-4C7F-9065-51117A0F54B9@comcast.net>
	<43A694DF.8040209@aitel.hist.no>
	<A3567036-A5F9-4CF9-BC48-70CFEAA8F2C4@comcast.net>
	<1135014201.10933.4.camel@localhost>
	<B1D5AEA1-A120-4997-AD9A-A2379B6A1779@comcast.net>
	<1135020446.10933.8.camel@localhost>
	<D5AD0C5C-CB2C-43AF-913E-23C1FFB1A50C@comcast.net>
	<1135024498.10933.13.camel@localhost>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 19 Dec 2005 22:34:57 +0200,
Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO> escribió:

> My point was that you don't know why those two OS have such a large
> stack. Just because you can't look at the source without being
> contaminated.

opensolaris is open source, you can look at their code.

But I don't think you'll find an answer there. My bet is: because
it'd be more difficult for their customers (even if opensolaris
is opensource it was born as propietary OS), because doing it
doesn't buys you performance and customers, there're not
lot of reasons for doing it, etc.

As I understand it, linux is "different". I'd say that the main
"philosophic" (not technical) reason for going 4K is: "because
we have the balls to write a 4k-stack-safe kernel". Quoting Linus:

"I hold open source people to higher standards. They are supposed to be
 the people who do programming because it's an art-form, not because it's
 their job."
