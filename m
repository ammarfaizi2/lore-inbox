Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWHRHRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWHRHRj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 03:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWHRHRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 03:17:39 -0400
Received: from smtp6.orange.fr ([193.252.22.25]:928 "EHLO
	smtp-msa-out06.orange.fr") by vger.kernel.org with ESMTP
	id S1750770AbWHRHRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 03:17:38 -0400
X-ME-UUID: 20060818071737586.8F0A71C0008B@mwinf0602.orange.fr
Subject: Re: [PATCH] net: restrict device names from having whitespace
From: Xavier Bestel <xavier.bestel@free.fr>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: David Miller <davem@davemloft.net>, 7eggert@gmx.de, cate@debian.org,
       7eggert@elstempel.de, mitch.a.williams@intel.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060817231127.6438324e@localhost.localdomain>
References: <20060816133811.GA26471@nostromo.devel.redhat.com>
	 <Pine.LNX.4.58.0608161636250.2044@be1.lrz>
	 <1155799783.7566.5.camel@capoeira>
	 <20060817.162340.74748342.davem@davemloft.net>
	 <20060818022057.GA27076@nostromo.devel.redhat.com>
	 <44E68C4E.8070607@osdl.org> <20060817231127.6438324e@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1155885446.7566.15.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Fri, 18 Aug 2006 09:17:26 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 08:11, Stephen Hemminger wrote:
> Don't allow spaces in network device names because it makes
> it difficult to provide text interfaces via sysfs.

Personally I would at least avoid all chars <= ' ', because an interface
name is meant to be displayed and these control chars do no good on a
console nor in X.

	Xav

