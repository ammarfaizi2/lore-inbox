Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbTHTRda (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 13:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbTHTRda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 13:33:30 -0400
Received: from quechua.inka.de ([193.197.184.2]:19420 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262102AbTHTRd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 13:33:29 -0400
From: Bernd Eckenfels <ecki-lkm@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.2X] "Undeletable" ARP entries?
In-Reply-To: <20030820162530.GF12023@merlin.emma.line.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19pWpp-0007If-00@calista.inka.de>
Date: Wed, 20 Aug 2003 19:33:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030820162530.GF12023@merlin.emma.line.org> you wrote:
> The question why this doesn't show up in "ip neigh" remains though.

You can use "ip neigh add|del proxy <ip> dev <dev>" but ip-route will not
list those entries. 

I am not sure if this is oversight or intention, as  Alexey somewhat prefers
to shift this problem to user mode solutions.

Gruss
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
