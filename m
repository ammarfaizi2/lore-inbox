Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbTIPUbw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 16:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbTIPUbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 16:31:52 -0400
Received: from port-212-202-185-245.reverse.qdsl-home.de ([212.202.185.245]:36014
	"EHLO gw.localnet") by vger.kernel.org with ESMTP id S262472AbTIPUbu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 16:31:50 -0400
Message-ID: <3F677394.4040104@trash.net>
Date: Tue, 16 Sep 2003 22:33:24 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030908 Debian/1.4-4
X-Accept-Language: en
MIME-Version: 1.0
To: Vishwas Raman <vishwas@eternal-systems.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Incremental update of TCP Checksum
References: <3F3C07E2.3000305@eternal-systems.com> <20030821134924.GJ7611@naboo> <3F675B68.8000109@eternal-systems.com>
In-Reply-To: <3F675B68.8000109@eternal-systems.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vishwas Raman wrote:

> Can anyone out there tell me the algorithm to update the checksum 
> without having to recalculate it. 


Have a look at net/ipv4/netfilter/ipt_TCPMSS.c (cheat_check).

Regards,
Patrick

