Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266099AbTIKFOU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 01:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266101AbTIKFOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 01:14:19 -0400
Received: from mail-06.iinet.net.au ([203.59.3.38]:11233 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266099AbTIKFOS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 01:14:18 -0400
Message-ID: <3F6004A7.6030705@ii.net>
Date: Thu, 11 Sep 2003 13:14:15 +0800
From: Wade <neroz@ii.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francesco Sportolari <francesco@unipg.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] yet another scheduler patch
References: <200309081740.03835.francesco@unipg.it> <200309091323.53036.francesco@unipg.it>
In-Reply-To: <200309091323.53036.francesco@unipg.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francesco Sportolari wrote:

>Now my patch works also on x86 platform, and it works well (for me).
>Please give it a try, any feedback is welcome!
>
>The attached diff is for 2.6.0-test5 and is only for ppc32 and i386 archs
>
>Ciao,
>-- Francesco
>  
>
Hi, could you alter this so that it does not mess around with kernel 
threads? It should
only adjust user processes. Sorry if it is doing the right thing, but 
[eg] pdflush has a prio
of 100 currently..

In general usage (no load, X 4.3.0 + gnome 2.2.x), applications start up 
slower.

Under a moderate load (make -j4) xmms will not skip but it fails the 
wiggle test.
Renicing X to -10 (it was at 0 before) does not seem to help.

[Machine is an Athlon 1200 (not a rating) with 384mb ram, ide disks with 
DMA
 enabled]

Hope this helps, somehow :-)

    - Wade



