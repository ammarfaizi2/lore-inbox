Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314491AbSEXSwj>; Fri, 24 May 2002 14:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314829AbSEXSwi>; Fri, 24 May 2002 14:52:38 -0400
Received: from line103-203.adsl.actcom.co.il ([192.117.103.203]:55301 "HELO
	alhambra.merseine.nu") by vger.kernel.org with SMTP
	id <S314491AbSEXSwh>; Fri, 24 May 2002 14:52:37 -0400
Date: Fri, 24 May 2002 21:49:35 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: David Woodhouse <dwmw2@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: change ppp_deflate.o module license string [was: ppp_deflate.o taints the kernel?]
Message-ID: <20020524214935.B18922@actcom.co.il>
In-Reply-To: <E17BGhc-0006V7-00@the-village.bc.nu> <29311.1022254271@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, 

Please apply trivial patch to ppp_deflate.o to change module license
to dual BSD/GPL, like 2.5, in order to avoid needlessly tainting the
kernel. 

diff -ur linux-2.4.19-pre8-vanilla/drivers/net/ppp_deflate.c linux-2.4.19-pre8/drivers/net/ppp_deflate.c
--- linux-2.4.19-pre8-vanilla/drivers/net/ppp_deflate.c	Sun Sep 30 21:26:07 2001
+++ linux-2.4.19-pre8/drivers/net/ppp_deflate.c	Fri May 24 21:43:44 2002
@@ -657,4 +657,4 @@
 
 module_init(deflate_init);
 module_exit(deflate_cleanup);
-MODULE_LICENSE("BSD without advertisement clause");
+MODULE_LICENSE("Dual BSD/GPL");

On Fri, May 24, 2002 at 04:31:11PM +0100, David Woodhouse wrote:
> 
> alan@lxorguk.ukuu.org.uk said:
> >  FAQ item - BSD license doesnt guarantee we have source. If its GPL
> > compatible someone should slap a GPL header on our copy and be done
> > with it
> 
> It's already marked 'Dual BSD/GPL' in your tree and in 2.5, I believe.
> I fixed it when I did the zlib changes.
-- 
Trewsday 2 Forelithe 7466

http://vipe.technion.ac.il/~mulix/
http://syscalltrack.sf.net/
