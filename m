Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264969AbSKETRs>; Tue, 5 Nov 2002 14:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265087AbSKETRs>; Tue, 5 Nov 2002 14:17:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34572 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264969AbSKETRr>; Tue, 5 Nov 2002 14:17:47 -0500
Message-ID: <3DC81ACD.10609@zytor.com>
Date: Tue, 05 Nov 2002 11:23:57 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Joel Becker <Joel.Becker@oracle.com>
CC: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Reconfiguring one SW-RAID when other RAIDs are running
References: <3DC762FC.8070007@zytor.com> <15815.32292.689774.895238@notabene.cse.unsw.edu.au> <3DC7A2B1.3050402@zytor.com> <20021105180644.GF17573@nic1-pc.us.oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:
> On Tue, Nov 05, 2002 at 02:51:29AM -0800, H. Peter Anvin wrote:
> 
>>I actually ended up using mdadm... I actually dislike it not using the 
>>raidtab file at least as an option; I find the raidtab file to be good 
>>documentation for what one had done.
> 
> 
> 	Well, lsraid -R can give you the raidtab back from an mdadm
> created array.  This can be nice and easy documentation.  In fact,
> there's no reason a boot script can't run
> 'lsraid -R -p > /etc/raidtab.boot'
> 

That's nice, but I still like to be able to use the "edit raidtab then
mkraid", mostly because I think I'm less likely to screw up that way.

	-hpa


