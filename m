Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266731AbTAFOJC>; Mon, 6 Jan 2003 09:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266763AbTAFOJC>; Mon, 6 Jan 2003 09:09:02 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:53124
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266731AbTAFOJB>; Mon, 6 Jan 2003 09:09:01 -0500
Subject: Re: fs corruption with 2.4.20 IDE+md+LVM
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Carl Wilhelm Soderstrom <chrome@real-time.com>
Cc: Dmitry Volkoff <vdb@mail.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030105224909.C24674@real-time.com>
References: <20030106021412.GA3993@server1>
	 <20030105224909.C24674@real-time.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041865322.17472.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 06 Jan 2003 15:02:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-06 at 04:49, Carl Wilhelm Soderstrom wrote:
> <flamebait>
> maybe I just missed the arguments since I wasn't reading LKML at the time;
> but *why* is IDE being revamped in the middle of a "stable" kernel series?
> however better it may be, I don't regard the existing situation as being bad
> enough to justify the risk.
> </flamebait>

You are reporting problems in 2.4.20. 2.4.20 doesn't have the revamped IDE...

The IDE is getting updated because

- Lots of new controllers dont work with the old code
- Lots of LBA48 problems exist with the older code
- SATA is right out with the older code
- Several existing controllers have weird bugs with the older code

I'd much prefer we didn't have to update the IDE too 8)

