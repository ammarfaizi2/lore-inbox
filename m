Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVCNIcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVCNIcY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 03:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVCNIcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 03:32:24 -0500
Received: from warden2-p.diginsite.com ([209.195.52.120]:48603 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261338AbVCNIcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 03:32:20 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Jones <davej@redhat.com>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Date: Mon, 14 Mar 2005 00:27:46 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: AGP bogosities
In-Reply-To: <20050314081721.GA13817@elf.ucw.cz>
Message-ID: <Pine.LNX.4.62.0503140026360.10211@qynat.qvtvafvgr.pbz>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
 <20050311021248.GA20697@redhat.com> <16944.65532.632559.277927@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0503101839530.2530@ppc970.osdl.org> <87vf7xg72s.fsf@devron.myhome.or.jp>
 <20050311222614.GH4185@redhat.com> <20050314081721.GA13817@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005, Pavel Machek wrote:

>> I'm fascinated that not a single person picked up on this problem
>> whilst the agp code sat in -mm. Even if DRI isn't enabled,
>> every box out there with AGP that uses the generic routines
>> (which is a majority), should have barfed loudly when it hit
>> this check during boot.  Does no-one read dmesg output any more ?
>
> Its way too long these days. Like "so long it overflows even enlarged
> buffer". We should prune these messages down to "one line per hw
> device or serious problems only".

especially if you turn on encryption options. I can understand that output 
being useful for debugging, but there should be a way to not deal with it 
in the normal case.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
