Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbTICJkc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 05:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbTICJkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 05:40:32 -0400
Received: from lns-th2-4f-81-56-212-215.adsl.proxad.net ([81.56.212.215]:64386
	"EHLO maverick.homelinux.com") by vger.kernel.org with ESMTP
	id S261698AbTICJkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 05:40:25 -0400
Message-ID: <3F55B738.4070200@eskuel.com>
Date: Wed, 03 Sep 2003 11:41:12 +0200
From: Mathieu LESNIAK <maverick@eskuel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030727 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       ebrunet@quatramaran.ens.fr, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Power Management Update
References: <Pine.LNX.4.44.0309021108040.5614-100000@cherise>
In-Reply-To: <Pine.LNX.4.44.0309021108040.5614-100000@cherise>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
  > I apologize for the delay in getting back to you - I wanted to test an
> actual fix, rather than just a work around.
> 
> I encountered this problem by having an IDE CD-ROM, but not having the 
> ide-cd drier compiled in. The patch below is from Benh, who wrote the IDE 
> power managment handlers. 
> 
> He mentioned producing a cleaner patch, but this should at least fix the 
> Oops. Please give it a try and report if it helps or not.
> 
> Thanks,
> 
> 
> 	Pat

Hi,

I've tested the patch you submitted for ide-io.c (I've tested it in 
test4-mm5).
It solves the ide-cd problem, and the suspend process get to next step. 
It frees memory. However, just after that, the system get in a loop 
displaying "Bad: scheduling while atomic". I'm not able to capture the 
output of this, the laptop only responding to syrq.
Hope it helps you.

Mathieu LESNIAK

