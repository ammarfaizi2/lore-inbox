Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262130AbSKMRSs>; Wed, 13 Nov 2002 12:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262147AbSKMRSs>; Wed, 13 Nov 2002 12:18:48 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:51142 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S262130AbSKMRSq>; Wed, 13 Nov 2002 12:18:46 -0500
Date: Wed, 13 Nov 2002 09:25:30 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Steven Dake <sdake@mvista.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>,
       Brian Jackson <brian-kernel-list@mdrx.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: md on shared storage
Message-ID: <20021113172530.GF806@nic1-pc.us.oracle.com>
References: <20021113002529.7413.qmail@escalade.vistahp.com> <20021113114641.GI19811@marowsky-bree.de> <3DD28914.3050107@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD28914.3050107@mvista.com>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 10:17:08AM -0700, Steven Dake wrote:
> Another method is to lock an md array to a specific host.  This method 
> requires no DLM (since there is no shared write to the same array 
> capability).

	But the entire point is to share access.  Otherwise it is pretty
uninteresting.
	If you want a failover setup, there is no need for md locking
either.  Simply have the backup node not start the md until the failover
happens.

Joel

-- 

"There are only two ways to live your life. One is as though nothing
 is a miracle. The other is as though everything is a miracle."
        - Albert Einstein

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
