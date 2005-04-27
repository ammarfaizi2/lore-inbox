Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbVD0VFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbVD0VFD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 17:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbVD0VFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 17:05:03 -0400
Received: from terminus.zytor.com ([209.128.68.124]:64445 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262012AbVD0VE6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 17:04:58 -0400
Message-ID: <426FFE58.4050901@zytor.com>
Date: Wed, 27 Apr 2005 14:04:24 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Florian Weimer <fw@deneb.enyo.de>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       magnus.damm@gmail.com, mason@suse.com, mike.taht@timesys.com,
       mpm@selenic.com, linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: Mercurial 0.3 vs git benchmarks
References: <aec7e5c305042608095731d571@mail.gmail.com>	<200504261138.46339.mason@suse.com>	<aec7e5c305042609231a5d3f0@mail.gmail.com>	<20050426135606.7b21a2e2.akpm@osdl.org>	<Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org>	<20050426155609.06e3ddcf.akpm@osdl.org> <426ED20B.9070706@zytor.com>	<871x8wb6w4.fsf@deneb.enyo.de>	<20050427151357.GH1087@cip.informatik.uni-erlangen.de>	<426FDFCD.6000309@zytor.com>	<20050427190144.GA28848@cip.informatik.uni-erlangen.de> <874qds5489.fsf@deneb.enyo.de>
In-Reply-To: <874qds5489.fsf@deneb.enyo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer wrote:
> 
> Benchmarks are actually a bit tricky because as far as I can tell,
> once you hash the directories, they are tainted even if you mount your
> file system with ext2.

That's what fsck -D is for.

	-hpa
