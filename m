Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261916AbTCaXfl>; Mon, 31 Mar 2003 18:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261927AbTCaXfl>; Mon, 31 Mar 2003 18:35:41 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:16771 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S261916AbTCaXfj>; Mon, 31 Mar 2003 18:35:39 -0500
Date: Mon, 31 Mar 2003 15:45:08 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Roman Zippel <zippel@linux-m68k.org>, bert hubert <ahu@ds9a.nl>,
       Greg KH <greg@kroah.com>, Andries.Brouwer@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: 64-bit kdev_t - just for playing
Message-ID: <20030331234508.GQ32000@ca-server1.us.oracle.com>
References: <Pine.LNX.4.44.0303280008530.5042-100000@serv> <20030327234820.GE1687@kroah.com> <Pine.LNX.4.44.0303281031120.5042-100000@serv> <20030328180545.GG32000@ca-server1.us.oracle.com> <Pine.LNX.4.44.0303281924530.5042-100000@serv> <20030331083157.GA29029@outpost.ds9a.nl> <Pine.LNX.4.44.0303311039190.5042-100000@serv> <20030331172403.GM32000@ca-server1.us.oracle.com> <Pine.LNX.4.44.0303312215020.5042-100000@serv> <1049149133.1287.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049149133.1287.1.camel@dhcp22.swansea.linux.org.uk>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 11:18:54PM +0100, Alan Cox wrote:
> Glibc already has a bigger dev_t

	Yes, but they hand-map 8:8 in functions like xmknod().  They
should really be using macros.

Joel

-- 

Life's Little Instruction Book #314

	"Never underestimate the power of forgiveness."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
