Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271971AbRIXVP0>; Mon, 24 Sep 2001 17:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271906AbRIXVPR>; Mon, 24 Sep 2001 17:15:17 -0400
Received: from pa147.antoniuk.sdi.tpnet.pl ([213.25.59.147]:52352 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S271847AbRIXVPA>; Mon, 24 Sep 2001 17:15:00 -0400
Date: Mon, 24 Sep 2001 23:11:58 +0200
From: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jpopl@interia.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: __alloc_pages: 0-order allocation failed
Message-ID: <20010924231158.A1824@localhost.localdomain>
In-Reply-To: <20010924040208.A624@localhost.localdomain> <Pine.LNX.4.21.0109240810300.1593-100000@freak.distro.conectiva> <20010924230345.A1540@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010924230345.A1540@localhost.localdomain>; from jpopl@interia.pl on Mon, Sep 24, 2001 at 11:03:46PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2001 at 11:03:46PM +0200, Jacek Pop³awski wrote:
> VM: killing process donkey_s
> free
>              total       used       free     shared    buffers     cached
> Mem:        320616     318732       1884          0        116     305480
> -/+ buffers/cache:      13136     307480
> Swap:       104380       9312      95068

and it's getting worse (donkey_s is already killed!):

             total       used       free     shared    buffers     cached
Mem:        320616     318828       1788          0        112     305596
-/+ buffers/cache:      13120     307496
Swap:       104380      10472      93908
[root@localhost /root]# __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
VM: killing process sendmail
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
VM: killing process sendmail
(...)

PS. uptime=5h, no problems before I started "donkey_s"
