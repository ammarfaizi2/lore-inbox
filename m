Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263502AbTCNUHo>; Fri, 14 Mar 2003 15:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263503AbTCNUHo>; Fri, 14 Mar 2003 15:07:44 -0500
Received: from comtv.ru ([217.10.32.4]:33434 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S263501AbTCNUHn>;
	Fri, 14 Mar 2003 15:07:43 -0500
X-Comment-To: Andrew Morton
To: Andrew Morton <akpm@digeo.com>
Cc: jlnance@unity.ncsu.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.5.64-mm6
References: <20030313032615.7ca491d6.akpm@digeo.com>
	<1047572586.1281.1.camel@ixodes.goop.org>
	<20030313113448.595c6119.akpm@digeo.com>
	<1047611104.14782.5410.camel@spc1.mesatop.com>
	<20030313192809.17301709.akpm@digeo.com>
	<20030314133126.GB2679@ncsu.edu>
	<20030314120537.715e5bf0.akpm@digeo.com>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 14 Mar 2003 23:10:20 +0300
In-Reply-To: <20030314120537.715e5bf0.akpm@digeo.com>
Message-ID: <m3y93haevn.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andrew Morton (AM) writes:

 AM> jlnance@unity.ncsu.edu wrote:
 >> 
 >> Andrew, I am not sure what you mean by this.  Are you saying that
 >> the way ld accesses files causes the blocks on the disk to be
 >> layed out poorly?  That is the only thing I can think of that
 >> would get fixed by copying.
 >> 

 AM> Exactly that.  ld seeks all over the file when adding new blocks
 AM> to it, so with ext2 and ext3 (at least) there is poor
 AM> correspondence between file offset and block indices.


hmm. I thought delayed allocation should solve this problem. Isn't it?

