Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVCLWeC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVCLWeC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 17:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVCLWdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 17:33:03 -0500
Received: from fire.osdl.org ([65.172.181.4]:49297 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262244AbVCLWcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 17:32:42 -0500
Date: Sat, 12 Mar 2005 14:34:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: Paul Mackerras <paulus@samba.org>, Dave Jones <davej@redhat.com>,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: AGP bogosities
In-Reply-To: <877jkcmrfr.fsf@devron.myhome.or.jp>
Message-ID: <Pine.LNX.4.58.0503121433520.2822@ppc970.osdl.org>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
 <20050311021248.GA20697@redhat.com> <16944.65532.632559.277927@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0503101839530.2530@ppc970.osdl.org> <87vf7xg72s.fsf@devron.myhome.or.jp>
 <Pine.LNX.4.58.0503120906020.2398@ppc970.osdl.org> <877jkcmrfr.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 13 Mar 2005, OGAWA Hirofumi wrote:
> 
> However, inode->i_writecount and some stuffs seems to be already using
> the negative values (or sparc was used the signed 24 bits value).
> 
> Anyway, unfortunately inode->i_writecount triggered in atomic_dec().

Ahh, you're right. Thanks for testing it out,

		Linus
