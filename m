Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133026AbRAGWCD>; Sun, 7 Jan 2001 17:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132867AbRAGWBx>; Sun, 7 Jan 2001 17:01:53 -0500
Received: from hq.yok.utu.fi ([130.232.128.220]:40085 "HELO hq.yok.utu.fi")
	by vger.kernel.org with SMTP id <S132201AbRAGWBh>;
	Sun, 7 Jan 2001 17:01:37 -0500
Date: Mon, 8 Jan 2001 00:01:30 +0200
From: Tommi Virtanen <tv-nospam-63ae21@debian.org>
To: Eric Lammerts <eric@lammerts.org>
Cc: Kernel devel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 and Maxtor 96147H6 (61 GB)
Message-ID: <20010108000130.A32052@hq.yok.utu.fi>
In-Reply-To: <Pine.LNX.4.21.0101042241420.4090-100000@server.serve.me.nl> <Pine.LNX.4.31.0101042316010.2045-100000@ally.lammerts.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0101042316010.2045-100000@ally.lammerts.org>; from eric@lammerts.org on Fri, Jan 05, 2001 at 12:34:11AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2001 at 12:34:11AM +0200, Eric Lammerts wrote:
> I had the same problem with my 80Gb Maxtor. (Asus P2L97, works with
> 60Gb but hangs with 80Gb :-/) After clipping the drive with ibmsetmax
> (http://www.uwsg.indiana.edu/hypermail/linux/kernel/0012.1/0249.html)
> and removing the jumper, unclipping worked fine (kernel is 2.2.18+ide).
> 
> Andre: can you add unclipping support to 2.4 too?

	I emailed a patch for 2.4.0-test13-pre5 some time
	ago, has been working fine here ever since.

http://www.uwsg.iu.edu/hypermail/linux/kernel/0012.3/0559.html

-- 
tv@{{hq.yok.utu,havoc,gaeshido}.fi,{debian,wanderer}.org,stonesoft.com}
Perl this: sub fibo() {my ($a,$b)=(1,0);sub{my $o=$a;$a=$b;$b=$o+$a;$b}}
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
