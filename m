Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVDBGWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVDBGWu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 01:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVDBGWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 01:22:50 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:1588 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261152AbVDBGWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 01:22:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=qN2FNwLLRY/YBqmVeizSL+7FMHPd6NpxrtUW8QTpqapAJuk/zzOyXS2vCO9lfjpkwBkGqQMS2LxqSYEeOs3YcQcG6Q4k9c0Tl/2ApYjy55MyDWzEIM1v/B6Jb6xBBfNzf+EyIG/FjePl9H8aXq5PyWirzibqN4GWUkTUaDtAfcQ=
Message-ID: <9e47339105040122225b96c774@mail.gmail.com>
Date: Sat, 2 Apr 2005 01:22:48 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: initramfs linus tree breakage in last day
Cc: davem@sunset.davemloft.net
In-Reply-To: <9e47339105040119302e6bb405@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <9e473391050401181824d9e50f@mail.gmail.com>
	 <9e47339105040119302e6bb405@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This will let me boot again. It is not obvious to me where the problem
is, it may have something to do with netlink or maybe memory
corruption?

bk export -tpatch -r1.2326,1.2327 >../foo.patch
patch -p1 -R <../foo.patch

# ChangeSet
#   2005/03/31 21:14:28-08:00 davem@sunset.davemloft.net
#   Merge bk://kernel.bkbits.net/acme/net-2.6
#   into sunset.davemloft.net:/home/davem/src/BK/net-2.6
#
# ChangeSet
#   2005/03/26 20:04:49-03:00 acme@toy.ghostprotocols.net
#   [NET] make all protos partially use sk_prot

-- 
Jon Smirl
jonsmirl@gmail.com
