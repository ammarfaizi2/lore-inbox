Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTGTILh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 04:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTGTILg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 04:11:36 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:28043 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S263462AbTGTILa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 04:11:30 -0400
Message-ID: <3F1A5219.6050405@portrix.net>
Date: Sun, 20 Jul 2003 10:26:01 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030709 Debian/1.4-1.he-1
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: 'NFS stale file handle' with 2.5
References: <3F1068C9.1070900@portrix.net> <16145.53527.749969.347814@gargle.gargle.HOWL>
In-Reply-To: <16145.53527.749969.347814@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Saturday July 12, j.dittmer@portrix.net wrote:
>>Problem:
>>Accessing the nfs shares on the Server gives lots of 'nfs stale file 
>>handles', making it unusuable. A simple cp from nfs to nfs triggers it 
>>in a matter of seconds.
> This makes me a bit suspicious of hardware, probably networking.  It
> really looks like data is getting corrupted between client and server.
> 
just as a data point 2.4.22pre6aa1 is working rock solid on the same machine - 
not one timeout yet in 2 days testing (an infinite loop of kernel compiles).

Thanks,

Jan

-- 
Linux rubicon 2.6.0-test1-mm1-jd1 #1 SMP Wed Jul 16 10:14:18 CEST 2003 i686

