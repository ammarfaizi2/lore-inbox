Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbTKQNIw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 08:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTKQNIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 08:08:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:13700 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263486AbTKQNIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 08:08:51 -0500
X-Authenticated: #4512188
Message-ID: <3FB8C92E.7030201@gmx.de>
Date: Mon, 17 Nov 2003 14:12:14 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: "Ronny V. Vindenes" <s864@ii.uib.no>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, cat@zip.com.au,
       gawain@freda.homelinux.org, gene.heskett@verizon.net,
       papadako@csd.uoc.gr
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
References: <1069071092.3238.5.camel@localhost.localdomain>
In-Reply-To: <1069071092.3238.5.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ronny V. Vindenes wrote:

> I've found that neither linus.patch nor
> context-switch-accounting-fix.patch is causing the problem, but rather
> acpi-pm-timer-fixes.patch & acpi-pm-timer.patch
> 
> With these applied my cpu (athlon64) is detected as 0.0Mhz, bogomips
> drops to 50% and anything cpu intensive destroys interactivity. Revert
> them and performance is back at -mm2 level.
> 

Yup, works for me too. Reverting those patches and my machine is smooth 
again. :)

Prakash

