Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286783AbRL1HYt>; Fri, 28 Dec 2001 02:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286782AbRL1HYj>; Fri, 28 Dec 2001 02:24:39 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:5638 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S286786AbRL1HYZ>; Fri, 28 Dec 2001 02:24:25 -0500
Date: Fri, 28 Dec 2001 02:24:22 -0500
From: Lennert Buytenhek <buytenh@gnu.org>
To: Narancs v1 <narancs@narancs.tii.matav.hu>
Cc: acsgabi@acsgabi.tii.matav.hu, linux-kernel@vger.kernel.org,
        manty@debian.org, bridge@math.leidenuniv.nl
Subject: Re: brctl 0.9.3 error on ultrasparc/linux 2.4.17
Message-ID: <20011228022421.C6101@gnu.org>
In-Reply-To: <Pine.LNX.4.43.0112271431280.30564-100000@helka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.43.0112271431280.30564-100000@helka>; from narancs@narancs.tii.matav.hu on Thu, Dec 27, 2001 at 02:50:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Bridging not working on ultra is a known problem which I haven't really
bothered to fix.  If you have a spare ultra somewhere you can let me ssh
into I'll have a look..


cheers,
Lennert


On Thu, Dec 27, 2001 at 02:50:49PM +0100, Narancs v1 wrote:

> Hi Lennert!
> 
> We have a big trouble here, we have a so called "firewall" which has 5 eth
> if.s and it is a sun ultra 5 ws. 2 ports should be used as an ethernet
> bridge for filtering IPX between 2 ethernet segments.
> 
> I have read all the docs which came with the bridge-utils package.
> 
> On intel we use the same kernel, similar kernel config and it is working
> fine.
> 
> on sparc we get this error message:
> 
> # brctl addbr br0
> br_add_bridge: operation not supported
> 
> bridge module is loaded
> 
> distribution is debian woody/sparc
> 
> Thank you for your great help!
> 
