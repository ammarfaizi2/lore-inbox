Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUFSTae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUFSTae (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 15:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUFSTae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 15:30:34 -0400
Received: from outmx008.isp.belgacom.be ([195.238.3.235]:51650 "EHLO
	outmx008.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S262279AbUFSTad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 15:30:33 -0400
Subject: Re: [PATCH 2.6.7] ext3 s_dirt for r/w
From: FabF <fabian.frederick@skynet.be>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040619115438.765da1c0.akpm@osdl.org>
References: <1087668287.2472.4.camel@localhost.localdomain>
	 <20040619115438.765da1c0.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1087673549.2224.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 19 Jun 2004 21:32:29 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-19 at 20:54, Andrew Morton wrote:
> FabF <fabian.frederick@skynet.be> wrote:
> >
> > 	Here is a patch setting s_dirt for read-write filesystems in ext3_init
> >  (doing it in create_journal seems troublesome IMHO).
> 
> Why?
ext3_create_journal is called with journal_inum parser option set which
means unjournaled r/w ext3 fs are s_dirt 0.
> 
> >  PS: untested
> 
> Please don't send untested patches.
Ok, tested.No problem here.

