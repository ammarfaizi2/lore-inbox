Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbSKESAc>; Tue, 5 Nov 2002 13:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265136AbSKESAc>; Tue, 5 Nov 2002 13:00:32 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:500 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S265135AbSKESAb>; Tue, 5 Nov 2002 13:00:31 -0500
Date: Tue, 5 Nov 2002 10:06:44 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Reconfiguring one SW-RAID when other RAIDs are running
Message-ID: <20021105180644.GF17573@nic1-pc.us.oracle.com>
References: <3DC762FC.8070007@zytor.com> <15815.32292.689774.895238@notabene.cse.unsw.edu.au> <3DC7A2B1.3050402@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC7A2B1.3050402@zytor.com>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 02:51:29AM -0800, H. Peter Anvin wrote:
> I actually ended up using mdadm... I actually dislike it not using the 
> raidtab file at least as an option; I find the raidtab file to be good 
> documentation for what one had done.

	Well, lsraid -R can give you the raidtab back from an mdadm
created array.  This can be nice and easy documentation.  In fact,
there's no reason a boot script can't run
'lsraid -R -p > /etc/raidtab.boot'

Joel

-- 

"We will have to repent in this generation not merely for the
 vitriolic words and actions of the bad people, but for the 
 appalling silence of the good people."
	- Rev. Dr. Martin Luther King, Jr.

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
