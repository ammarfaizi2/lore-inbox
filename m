Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbVD2Btu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbVD2Btu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 21:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVD2Btu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 21:49:50 -0400
Received: from quechua.inka.de ([193.197.184.2]:59301 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262371AbVD2Btq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 21:49:46 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] dlm: overview
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <Pine.LNX.4.62.0504281731450.6139@qynat.qvtvafvgr.pbz>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1DRKdT-00013X-00@calista.eckenfels.6bone.ka-ip.net>
Date: Fri, 29 Apr 2005 03:49:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.62.0504281731450.6139@qynat.qvtvafvgr.pbz> you wrote:
> how is this UUID that doesn't need to be touched by an admin, and will 
> always work in all possible networks (including insane things like backup 
> servers configured with the same name and IP address as the primary with 
> NAT between them to allow them to communicate) generated?
> 
> there are a lot of software packages out there that could make use of 
> this.

It is hard to work in all cases :)

if you use v4 UUID they are a 128bit random bitstring, others depend on the
MAC (plus random). 

Greetings
Bernd
