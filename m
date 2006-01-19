Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161460AbWASWdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161460AbWASWdJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161462AbWASWdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:33:08 -0500
Received: from mx1.suse.de ([195.135.220.2]:44751 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161460AbWASWdG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:33:06 -0500
From: Neil Brown <neilb@suse.de>
To: Phillip Susi <psusi@cfl.rr.com>
Date: Fri, 20 Jan 2006 09:32:51 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17360.5011.975665.371008@cse.unsw.edu.au>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Lincoln Dale (ltd)" <ltd@cisco.com>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
In-Reply-To: message from Phillip Susi on Thursday January 19
References: <26A66BC731DAB741837AF6B2E29C1017D47EA0@xmb-hkg-413.apac.cisco.com>
	<Pine.LNX.4.61.0601181427090.19392@yvahk01.tjqt.qr>
	<17358.52476.290687.858954@cse.unsw.edu.au>
	<43D00FFA.1040401@cfl.rr.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday January 19, psusi@cfl.rr.com wrote:
> I'm currently of the opinion that dm needs a raid5 and raid6 module 
> added, then the user land lvm tools fixed to use them, and then you 
> could use dm instead of md.  The benefit being that dm pushes things 
> like volume autodetection and management out of the kernel to user space 
> where it belongs.  But that's just my opinion...

The in-kernel autodetection in md is purely legacy support as far as I
am concerned.  md does volume detection in user space via 'mdadm'.

What other "things like" were you thinking of.

NeilBrown
