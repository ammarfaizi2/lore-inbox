Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269756AbUHZWNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269756AbUHZWNi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269749AbUHZWK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:10:59 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:17306 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S269642AbUHZWDo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:03:44 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16686.24120.761440.969273@thebsh.namesys.com>
Date: Fri, 27 Aug 2004 02:03:36 +0400
To: Christophe Saout <christophe@saout.de>
Cc: Dmitry Baryshkov <mitya@school.ioffe.ru>, Hans Reiser <reiser@namesys.com>,
       Andrew Morton <akpm@osdl.org>, hch@lst.de,
       linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>, flx@namesys.com,
       torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <1093556818.13881.75.camel@leto.cs.pocnet.net>
References: <20040824202521.GA26705@lst.de>
	<412CEE38.1080707@namesys.com>
	<20040825152805.45a1ce64.akpm@osdl.org>
	<412D9FE6.9050307@namesys.com>
	<20040826014542.4bfe7cc3.akpm@osdl.org>
	<412DAC59.4010508@namesys.com>
	<1093548414.5678.74.camel@krustophenia.net>
	<20040826203017.GA14361@school.ioffe.ru>
	<1093552692.13881.43.camel@leto.cs.pocnet.net>
	<16686.22336.829096.678178@thebsh.namesys.com>
	<1093556818.13881.75.camel@leto.cs.pocnet.net>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout writes:
 > Am Freitag, den 27.08.2004, 01:33 +0400 schrieb Nikita Danilov:
 > 
 > > Wrong, plugin is called just below entry point from the VFS to the
 > > file-system back-end. It can use reiser4 tree, or any storage layer it
 > > wants. Or none at all: think about pseudo-files like
 > > foo/metas/uid---they are also implemnted by plugins.
 > 
 > Yes. But which plugins are we talking about?
 > 
 > What about fs/reiser4/plugin/node/ and fs/reiser4/plugin/disk_format/?
 > 
 > Of course you can implement another filesystem inside the plugins but
 > they wouldn't use fs/reiser4/*.c, so this would be rather stupid. Right?
 > 

That was the message of my message.

Nikita.
