Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267600AbUHWJI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267600AbUHWJI3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 05:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267610AbUHWJI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 05:08:26 -0400
Received: from quechua.inka.de ([193.197.184.2]:9945 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S267600AbUHWJH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 05:07:57 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Trivial IPv6-for-Fedora HOWTO
Organization: Deban GNU/Linux Homesite
In-Reply-To: <cgbv4e$pd6$1@sea.gmane.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BzAnz-0005kS-00@calista.eckenfels.6bone.ka-ip.net>
Date: Mon, 23 Aug 2004 11:07:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <cgbv4e$pd6$1@sea.gmane.org> you wrote:
> And what exactly does this mean?
> 
> "terminate the tunnel on your firewall" ???

it means  that you should not forward the tunnel packets to internal hosts
but to configure the tunnel endpoint interface on (or before) the firewall.

> Would you enlighten me (and the list) how do you do that with ip{,6}tables?

Then you can run normal rules on the decapsulated packets.

Gruss
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
