Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318141AbSHDKGd>; Sun, 4 Aug 2002 06:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318140AbSHDKGd>; Sun, 4 Aug 2002 06:06:33 -0400
Received: from jalon.able.es ([212.97.163.2]:45780 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S318141AbSHDKGc>;
	Sun, 4 Aug 2002 06:06:32 -0400
Date: Sun, 4 Aug 2002 12:09:21 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 make allyesconfig - errors and warnings
Message-ID: <20020804100921.GA1353@junk>
References: <28360.1028454667@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <28360.1028454667@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on dom, ago 04, 2002 at 11:51:07 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020804 Keith Owens wrote:
> 2.4.19 make allyesconfig got two errors and lots of warnings.
> 
> CONFIG_JFFS2_FS - duplicate symbols between jffs2 and ppp_deflate - an
> oldy but goody.
> 

The only way to clean that for future is to include David Woodhouse's 
shared zlib patch. It cleans jffs2 and some more things.

-- 
J.A. Magallon                           \                 Software is like sex:
junk.able.es                             \           It's better when it's free
Mandrake Linux release 9.0 (Cooker) for i586
Linux 2.4.19-jam0 (gcc 3.2 (Mandrake Linux 9.0 3.2-0.2mdk))
