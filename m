Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUHML0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUHML0g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 07:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUHML0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 07:26:34 -0400
Received: from quechua.inka.de ([193.197.184.2]:46469 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261474AbUHML0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 07:26:32 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let W1 select NET
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20040813110137.GY13377@fs.tum.de>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BvaCd-0006oR-00@calista.eckenfels.6bone.ka-ip.net>
Date: Fri, 13 Aug 2004 13:26:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040813110137.GY13377@fs.tum.de> you wrote:
> In the case of NET the discussion is mostly hypothetically since nearly 
> everyone has enabled NET.

Especially  in the case where it is unlikely that somebody is deselecting
NET, it makes more sense to depend on it, since IFF somebody deselects NET
(i.e. embedding) he wants to actually see which drivers are still available
(and she does not expect to see stil network drivers which reverse her
selection).

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
