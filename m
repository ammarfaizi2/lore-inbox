Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275968AbRJGAxx>; Sat, 6 Oct 2001 20:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275981AbRJGAxn>; Sat, 6 Oct 2001 20:53:43 -0400
Received: from ppp03.ts3-2.NewportNews.visi.net ([209.8.198.131]:43247 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S275968AbRJGAxh>; Sat, 6 Oct 2001 20:53:37 -0400
Date: Sat, 6 Oct 2001 20:28:31 -0400
From: Ben Collins <bcollins@debian.org>
To: Tony Hoyle <tmh@nothing-on.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops using ohci1394 on 2.4.10-ac4
Message-ID: <20011006202831.G13602@visi.net>
In-Reply-To: <9po6g0$9qu$1@sisko.my.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9po6g0$9qu$1@sisko.my.home>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2001 at 01:09:36AM +0100, Tony Hoyle wrote:
> I've been trying to get my 1394 card working on Linux...  It's possible
> this card (D-Link DFW500) isn't supported, but it probably shouldn't oops
> :-)
> 
> No devices are connected to the card at this point.  Booted into the
> console.  SMP kernel with noapic,nosmp to eliminate smp bugs...

Please try either the 2.4.11-pre4 code (which is very much changed from
the 2.4.10 code), or use the linux1394.sourceforge.net CVS. Several
known problems were fixed in recent code against 2.4.10.


Ben

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
