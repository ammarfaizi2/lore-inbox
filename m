Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317508AbSIIQh6>; Mon, 9 Sep 2002 12:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317512AbSIIQh6>; Mon, 9 Sep 2002 12:37:58 -0400
Received: from ns.ithnet.com ([217.64.64.10]:11023 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S317508AbSIIQh5>;
	Mon, 9 Sep 2002 12:37:57 -0400
Date: Mon, 9 Sep 2002 18:42:30 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Ryan S. Upton" <rupton@pobox.com>
Cc: greearb@candelatech.com, linux-kernel@vger.kernel.org
Subject: Re: DFE-580TX problems you posted on 05-24-02
Message-Id: <20020909184230.0f3d35a1.skraw@ithnet.com>
In-Reply-To: <20020905213555.GB31524@pobox.com>
References: <20020723203037.GA29459@pobox.com>
	<3D3DCD2C.1050004@candelatech.com>
	<20020905213555.GB31524@pobox.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2002 14:35:55 -0700
"Ryan S. Upton" <rupton@pobox.com> wrote:

Hello all,

regarding DFE-580TX I have some additions:
1) the 2.4.20-pre5 included sundance.c does not work at all with a recent
Dlink-card, the interface statistics show complete garbage and there is no
link possible.
2) The dlink driver Ryan points to does not handle mixed 10- and 100-MBit
configuration. 100 MBit wins, 10 Mbit gives no link.
3) Donalds' drivers (www.scyld.com) cannot be statically linked with the
kernel, there are dups in pci-scan.c and the current 2.4 kernel.

=>

1) In fact I wouldn't buy DFE-580TX today if I had a real chance of finding a 4
port tulip-driven card...
2) For 2.4-kernel something should be done, because currently the situation is
a mess.

Regards,
Stephan



> Thanks, and hopefully this too will lighten your load. I was able to find a
> driver that does work for the DFE-580TX. It appears to be a derrivitive of
> DB's sundance 1.03a. It is being distributed from a dlink site and the
> license "MODULE_LICENSE" tag has been modified (removed) so this may taint
> GPL-Free-LGPL pristine machines, but the GPL still remains at the top... (?)
> IANAL. 
> 
> Thanks to whoever modified this to work with the DFE-580TX (MIND THE LICENSE
> THOUGH!) and to everyone who posted allowing me to find this. Here's the
> link. 
> 
> http://tsd.dlink.com.tw/info.nsf/80d023dbef05f90048256adf002a91be/6dbbd6ab52943b1348256bd6002a4b4e?OpenDocument
> 
> -R
> Ryan S. Upton
> ryanu@pobox.com
