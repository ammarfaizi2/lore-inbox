Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270283AbTHQPMI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 11:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270291AbTHQPMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 11:12:08 -0400
Received: from quechua.inka.de ([193.197.184.2]:52356 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S270283AbTHQPMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 11:12:06 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
In-Reply-To: <200308171555280781.0067FB36@192.168.128.16>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19oPCN-0007tr-00@calista.inka.de>
Date: Sun, 17 Aug 2003 17:12:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200308171555280781.0067FB36@192.168.128.16> you wrote:
> So, if you have a router performing Proxy ARP... you don't need to
> reply to the "bad" Linux ARP Request, right?

Linux does not do bad requests, it does only do "bad" answers.

> "An ARP request is discarded if the source IP address is not in the
> same subnet."

In the same subnet of what? Sure it is in the same subnet as the host, since
it counts all its interfaces, wich is generally a good thing.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
