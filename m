Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269837AbUJMUoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269837AbUJMUoO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 16:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269841AbUJMUoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 16:44:14 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:35171 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269837AbUJMUoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 16:44:03 -0400
Message-ID: <9625752b04101313445a67923@mail.gmail.com>
Date: Wed, 13 Oct 2004 13:44:02 -0700
From: Danny <dannydaemonic@gmail.com>
Reply-To: Danny <dannydaemonic@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: mm kernel oops with r8169 & named, PREEMPT
Cc: netdev@oss.sgi.com
In-Reply-To: <20041013181840.GA30852@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9625752b041012230068619e68@mail.gmail.com>
	 <9625752b041013091772e26739@mail.gmail.com>
	 <9625752b04101309182a96fbd2@mail.gmail.com>
	 <200410131129.05657.jdmason@us.ltcfwd.linux.ibm.com>
	 <20041013181840.GA30852@electric-eye.fr.zoreil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2004 20:18:40 +0200, Francois Romieu wrote:
> Danny, can your drop the r8169 driver from 2.6.9-rc4-mm1 into vanilla
> 2.6.9-rc4 and confirm that it works (preempt should not matter) ?

I see how the timing on the installation of the r8169 could have just
been bad.  Since preempt shouldn't matter, I'm going to test that
and acpi etc first (because it's easier to test heh).

See, well, I'm going to need reiser4 for the vanilla.  I found patches here:
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out/

But can someone point out which patches I will need?  Do I only need
reiser4-only.patch or is it safer for my fs if I have all the other
reiser4 patches?
