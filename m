Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266874AbUAXGN2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 01:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266875AbUAXGN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 01:13:28 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:61928 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266874AbUAXGNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 01:13:25 -0500
Message-ID: <40120DD0.7090802@comcast.net>
Date: Sat, 24 Jan 2004 00:16:48 -0600
From: Karl Tatgenhorst <ketatgenhorst@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [lkml] pseudo tty / kernel compile question
References: <Pine.LNX.4.44.0401131148070.18661-100000@eloth> <20040113113650.A2975@flint.arm.linux.org.uk> <20040113114948.B2975@flint.arm.linux.org.uk> <20040113171544.B7256@flint.arm.linux.org.uk> <20040113172441.C7256@flint.arm.linux.org.uk>
In-Reply-To: <20040113172441.C7256@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have read the FAQ and have searched heartily for anything which I 
could understand about this, but have come up empty. I am replacing a 
Unixware 7.1.1 server (not a unixware question) with RH ES3. The server 
hosts a BASIC application so users log in via ssh sessions. The problem 
is I am getting to around 120 users and then getting a no pseudo ttys 
available. RH support had me bump up the number of instances in 
xinetd.conf which did nothing. Then a person we use for Unix support 
said that the type of pseudo ttys that we use is wrong. His example:

when I log in over ssh I get /dev/pts/0 when I type tty. But he says it 
should be of type /dev/ptsp* I know (suspect strongly) that this is 
configured in the kernel but not where. Can anyone please post a little 
information for me regarding this.

I heartily welcome your assistance in smiting this unixware servers job.

Karl Tatgenhorst

PS if it is not too much further trouble, please CC any responses to 
ktatgenhorst@eiltd.com

Thanks one and all

