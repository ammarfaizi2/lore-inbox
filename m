Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbTFPBCZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 21:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbTFPBCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 21:02:25 -0400
Received: from vcgwp1.bit-drive.ne.jp ([211.9.32.211]:56476 "HELO
	vcgwp1.bit-drive.ne.jp") by vger.kernel.org with SMTP
	id S263187AbTFPBCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 21:02:24 -0400
To: mikpe@csd.uu.se
Cc: linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Cc: hyoshiok@miraclelinux.com, hardmeter-users@lists.sourceforge.jp
Subject: Re: [Perfctr-devel] perfctr-2.5.5 released
In-Reply-To: <200306160044.h5G0i6Su026505@harpo.it.uu.se>
References: <200306160044.h5G0i6Su026505@harpo.it.uu.se>
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Cuyahoga Valley)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20030616095803N.hyoshiok@miraclelinux.com>
Date: Mon, 16 Jun 2003 09:58:03 +0900
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 16 Jun 2003 09:18:46 +0900, Hiro Yoshioka wrote:
> > I just download perfctr 2.5.5 and see the difference
> > between 2.5.4 and 2.5.5 but I could not find code
> > changes except the changelog and todo.
> > 
> > $ diff -u perfctr-2.5.4 perfctr-2.5.5
> > diff -u perfctr-2.5.4/CHANGES perfctr-2.5.5/CHANGES
> > --- perfctr-2.5.4/CHANGES       2003-06-01 21:32:45.000000000 +0900
> > +++ perfctr-2.5.5/CHANGES       2003-06-16 07:11:23.000000000 +0900
> 
> Missing '-r' option to diff, so it only diffs the toplevel files.
> Use diff -ruN to compare two directories recursively.

Thanks for your quick help.

I have made a patch for perfctr 2.5.5 of hardmeter which 
is a memory profiling tool using Intel P4's PEBS (precise
event based sampling) hardware monitoring facility.

See the following patch.

http://cvs.sourceforge.jp/cgi-bin/viewcvs.cgi/hardmeter/hardmeter/patch/perfctr-2.5.5.dif?rev=1.1&content-type=text/vnd.viewcvs-markup

https://sourceforge.jp/projects/hardmeter/
(some pages are written in Japanese)

Regards,
  Hiro
--
Hiro Yoshioka/CTO, Miracle Linux
mailto:hyoshiok@miraclelinux.com
http://www.miraclelinux.com
