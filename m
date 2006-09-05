Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161038AbWIEU1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbWIEU1P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 16:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161037AbWIEU1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 16:27:15 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:32943 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1161038AbWIEU1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 16:27:14 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44FDDD83.1010803@s5r6.in-berlin.de>
Date: Tue, 05 Sep 2006 22:26:43 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Miles Lane <miles.lane@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       linux1394-devel@lists.sourceforge.net
Subject: Re: 2.6.18-rc5-mm1 + all hotfixes -- INFO: possible recursive locking
 detected
References: <a44ae5cd0609051037k47d1ad7dsa8276dc0cec416bf@mail.gmail.com>	 <20060905111306.80398394.akpm@osdl.org> <a44ae5cd0609051249y767eed58ja1fe1b27858f5cd@mail.gmail.com> <44FDDBE7.1040906@s5r6.in-berlin.de>
In-Reply-To: <44FDDBE7.1040906@s5r6.in-berlin.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
[...]
> Now open patches/series in an editor. Find the ieee1394 patches. Move
> all of them to the bottom of the series file. Save it. You can now
> revert each 1394 patch by
> $ quilt pop

(Repeat until git-ieee1394.patch was removed.)

> Build the kernel as usual.

(Of course you just need to build, install, and reload the kernel
modules if you have ieee1394 configured as module.)
-- 
Stefan Richter
-=====-=-==- =--= --=-=
http://arcgraph.de/sr/
