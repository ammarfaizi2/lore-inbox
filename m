Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261682AbTCKXvQ>; Tue, 11 Mar 2003 18:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261690AbTCKXvQ>; Tue, 11 Mar 2003 18:51:16 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:28097
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261682AbTCKXvP>; Tue, 11 Mar 2003 18:51:15 -0500
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0303111702170.13969-100000@divine.city.tvnet.hu>
References: <Pine.LNX.4.30.0303111702170.13969-100000@divine.city.tvnet.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047431368.20675.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 12 Mar 2003 01:09:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-11 at 16:29, Szakacsits Szabolcs wrote:
> Randy's compliler is 2.96 and it forgot to do a 'sub $0xc,%esp'. See
> yourself all the data at http://bugme.osdl.org/show_bug.cgi?id=432
> 
> Red Hat had this bug also for 1-1.5 year (there is a bugzilla entry
> submitted by a Parasoft employee, the bug also screw[s|ed] user space
> apps, e.g. by signal handling).

Thanks for the reference. It does indeed look like its a longer standing 
bug than some of us thought. 

