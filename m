Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311716AbSCNS21>; Thu, 14 Mar 2002 13:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311717AbSCNS2R>; Thu, 14 Mar 2002 13:28:17 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:19819 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S311716AbSCNS2K>; Thu, 14 Mar 2002 13:28:10 -0500
Message-ID: <3C90EB9D.617F22B0@ngforever.de>
Date: Thu, 14 Mar 2002 11:27:41 -0700
From: Thunder from the hill <thunder@ngforever.de>
Organization: The LuckyNet Administration
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.8-26mdk i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andreas Dilger <adilger@clusterfs.com>, David Rees <dbr@greenhydrant.com>
Subject: Re: mke2fs (and mkreiserfs) core dumps
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> If you don't have any "ulimit" calls in the login, it should also be OK.
> It's just that some vendor startup scripts set a ulimit for non-root
> users.  Trying to set it back to "unlimited" doesn't work.
> 
> Cheers, Andreas

Not exactly, there's a trap: Some models have a
/etc/security/limits.conf which might ulimit some stuff even though you
don't have any direct calls to ulimit. I had already encountered this
several times and wondered if I might consider this a misbehavior.
Anyway, these limits don't apply to root then in the model. I don't know
if this problem is based on that.

Thunder
