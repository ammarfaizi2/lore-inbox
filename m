Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266298AbSL2B4x>; Sat, 28 Dec 2002 20:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266316AbSL2B4x>; Sat, 28 Dec 2002 20:56:53 -0500
Received: from [217.13.199.129] ([217.13.199.129]:18137 "EHLO
	server1.netdiscount.de") by vger.kernel.org with ESMTP
	id <S266298AbSL2B4w>; Sat, 28 Dec 2002 20:56:52 -0500
Date: Sun, 29 Dec 2002 03:05:10 +0100
From: Christian Leber <christian@leber.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021229020510.GA22540@core.home>
References: <200212090830.gB98USW05593@flux.loup.net> <at2l1t$g5n$1@penguin.transmeta.com> <20021209193649.GC10316@suse.de> <at2rv7$fkr$1@cesium.transmeta.com> <20021228203706.GD1258@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20021228203706.GD1258@niksula.cs.hut.fi>
User-Agent: Mutt/1.4i
X-Accept-Language: de en
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2002 at 10:37:06PM +0200, Ville Herva wrote:

> Now that Linus has killed the dragon and everybody seems happy with the
> shiny new SYSENTER code, let just add one more stupid question to this
> thread: has anyone made benchmarks on SYSCALL/SYSENTER/INT80 on Athlon? Is
> SYSCALL worth doing separately for Athlon (and perhaps Hammer/32-bit mode)?

Yes, the output of the programm Linus posted is on a Duron 750 with
2.5.53 like this:

igor3:~# ./a.out
187.894946 cycles  (call 0xffffe000)
299.155075 cycles  (int 80)

(cycles per getpid() call)


Christian Leber

-- 
  "Omnis enim res, quae dando non deficit, dum habetur et non datur,
   nondum habetur, quomodo habenda est."       (Aurelius Augustinus)
  Translation: <http://gnuhh.org/work/fsf-europe/augustinus.html>
