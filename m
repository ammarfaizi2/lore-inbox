Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267453AbUHDWII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267453AbUHDWII (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 18:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267457AbUHDWII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 18:08:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:12735 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267453AbUHDWID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 18:08:03 -0400
Date: Wed, 4 Aug 2004 14:46:56 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: mingo@elte.hu, mbligh@aracnet.com, akpm@osdl.org, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, ricklind@us.ibm.com,
       nickpiggin@yahoo.com.au
Subject: Re: 2.6.8-rc2-mm2, schedstat-2.6.8-rc2-mm2-A4.patch
Message-Id: <20040804144656.2899d978.rddunlap@osdl.org>
In-Reply-To: <20040804213454.GA7661@mars.ravnborg.org>
References: <20040804122414.4f8649df.akpm@osdl.org>
	<211490000.1091648060@flay>
	<20040804212658.GA26023@elte.hu>
	<20040804213454.GA7661@mars.ravnborg.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2004 23:34:54 +0200 Sam Ravnborg wrote:

| On Wed, Aug 04, 2004 at 11:26:58PM +0200, Ingo Molnar wrote:
|  
| > I fixed a number of cleanliness items, readying this patch for a
| > mainline merge:
| > 
| >  - added kernel/Kconfig.debug for generic debug options (such as 
| >    schedstat) and removed tons of debug options from various arch
| >    Kconfig's, instead of adding a boatload of new SCHEDSTAT entries. 
| >    This felt good.
| 
| Randy Dunlap has posted a patch for this several times.
| This has seen some review so the preferred starting point.

Latest version is
  http://developer.osdl.org/rddunlap/kconfig/kconfig-debug-268-rc2bk9.patch

It applies cleanly to 2.6.8-rc3 and might make it into
early 2.6.8 ++ patches.

--
~Randy
