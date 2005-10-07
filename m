Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVJGEmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVJGEmq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 00:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbVJGEmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 00:42:46 -0400
Received: from koto.vergenet.net ([210.128.90.7]:39591 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S932110AbVJGEmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 00:42:45 -0400
Date: Fri, 7 Oct 2005 13:39:27 +0900
From: Horms <horms@verge.net.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Colin Leroy <colin@colino.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
Subject: Re: [PATCH] hfs, hfsplus: don't leak s_fs_info and fix an oops
Message-ID: <20051007043924.GA20827@verge.net.au>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Colin Leroy <colin@colino.net>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Cluestick: seven
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been looking over CAN-2005-3109, better known as
the hfs, hfsplus leak and oops, and I am wondering if the 
problem is present in 2.4

I took a look at making a backport, and it seems that
some of the problems are there, but without a deeper inspection
of the code its difficult to tell if the problems manifest or not.

For reference, here is the 2.6 variant of the change:
http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=945b092011c6af71a0107be96e119c8c08776f3f

I can futher my backport effort and post it for inspection if need be.

-- 
Horms
