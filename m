Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVDQTp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVDQTp2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 15:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVDQTp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 15:45:27 -0400
Received: from quechua.inka.de ([193.197.184.2]:53451 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261441AbVDQTpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 15:45:16 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Why Ext2/3 needs immutable attribute?
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <4ae3c14050417085473bd365f@mail.gmail.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1DNFhh-0006Rz-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 17 Apr 2005 21:45:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <4ae3c14050417085473bd365f@mail.gmail.com> you wrote:
> Why not simply unset the write bit for all three groups of users? 
> That seems to be enough to prevent file modification.

# touch test
# chmod a-w test
# echo test > test
# cat test
test

Because this does not protect against writes from root and it does not
protect against root setting the flags again.

Greetings
Bernd
