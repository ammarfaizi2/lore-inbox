Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUITEqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUITEqN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 00:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266048AbUITEqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 00:46:13 -0400
Received: from sputnik.senvnet.fi ([80.83.5.69]:17168 "EHLO sputnik.senvnet.fi")
	by vger.kernel.org with ESMTP id S266034AbUITEqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 00:46:11 -0400
Date: Mon, 20 Sep 2004 07:46:10 +0300 (EEST)
From: Jussi Hamalainen <count@theblah.fi>
X-X-Sender: count@mir.senvnet.fi
To: Thierry Coutelier <Thierry.Coutelier@linux.lu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Freeze on 2.4 kernels.
In-Reply-To: <414AEE92.6060500@linux.lu>
Message-ID: <Pine.LNX.4.58.0409200736380.6383@mir.senvnet.fi>
References: <414AEE92.6060500@linux.lu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2004, Thierry Coutelier wrote:

> The kernels range from 2.4.6 to 2.4.25 with some modifications
> (tcp_input). We tried with the standard kernel with the only
> change that the dev_alloc_name has been changed to support
> up to 900 names.
>
>
> The Hardware are Dell PowerEdge with Perc2 or Perc3. We tried with HP
> servers and have the same problem. We tried different firmware releases
> for the Perc cards and still no change.

I think I might be experiencing the same problem here with dual-p3
1.4GHz PE2550 boxes without PERC. We have a bunch of them doing SMTP
and webmail and every now and then one of them freezes for no
apparent reason. I don't get _anything_ on the console and nothing in
the logs.  Haven't tried serial console though.

This isn't a big problem for me since this happens randomly about
every 9 weeks or so. Since the boxes are in redundant pairs I've just
shrugged it off as being a general case of piece-of-crap PC hardware.
I just thought I should add my two cents' worth...

I've gone through kernels 2.4.16 to 2.4.26 with and without various
patches and nothing seems to make a difference.

-- 
-=[ Count Zero / TBH - Jussi Hämäläinen - email count@theblah.fi ]=-
