Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317633AbSHHQP4>; Thu, 8 Aug 2002 12:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317636AbSHHQP4>; Thu, 8 Aug 2002 12:15:56 -0400
Received: from daimi.au.dk ([130.225.16.1]:58068 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S317633AbSHHQPz>;
	Thu, 8 Aug 2002 12:15:55 -0400
Message-ID: <3D529A0E.F1C0E5FB@daimi.au.dk>
Date: Thu, 08 Aug 2002 18:19:26 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Bryan K. Walton" <thisisnotmyid@tds.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: problems with 1gb ddr memory sticks on linux
References: <20020808160456.GI16225@weccusa.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan K. Walton" wrote:
> 
> I have a box running Debian 3.0 with a Via C3 800mhz processor
> that slows to a crawl when I put in a 1GB stick of PC2100 DDR memory.
> 
> The board, a Gigabyte GA-6RX, supports this memory stick.

Could it be the case, that it really doesn't support that
memory eventhough it claims to?

> My 2.4.18 kernel is compiled with High Memory support and linux and the
> bios see all of the memory.

Did you try without High Memory support?

> However, the box is VERY slow.  It takes
> about 5 minutes to install .deb binary.  It took me 12 hours to compile
> the 2.4.18 kernel!
> 
> Here is what I have done to rule things out . . .
> 
> 1) The box runs FAST with M$ Windows 2000.
> 2) The box runs FAST when using identical kinds of memory but in
> quantities of 512MB or less.

Did you try with a total of 1024MB on two 512MB modules?

> 3) The box runs slow with other linux distos also. (I tried Redhat 7.2)
> 
> It seems to me that the problem has something to do with the linux
> kernel and 1GB memory sticks.  Am I off base?

Try the "slow" memory and use a mem= boot option to tell the
Linux kernel not to use all of it.

> 
> Anyone have any ideas?

I wonder if it could be the case, that it for some reason doesn't
use cache for all the memory.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
