Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272062AbRIQSwU>; Mon, 17 Sep 2001 14:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272465AbRIQSwK>; Mon, 17 Sep 2001 14:52:10 -0400
Received: from smtp3.libero.it ([193.70.192.53]:6316 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S272062AbRIQSwD>;
	Mon, 17 Sep 2001 14:52:03 -0400
Message-ID: <3BA4B614.82E08CB@denise.shiny.it>
Date: Sun, 16 Sep 2001 16:24:20 +0200
From: Giuliano Pochini <pochini@denise.shiny.it>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.10-pre9 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: Roberto Ragusa <robertoragusa@technologist.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] A nicer nice scheduling
In-Reply-To: <yam8658.2192.152344160@mail.inwind.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Ragusa wrote:
> 
> Hi,
> 
> please consider including this patch in the main kernel.
> It was proposed on 11/04/2001 by Rik van Riel
> ([test-PATCH] Re: [QUESTION] 2.4.x nice level)
> 
> This patch has been working great for me, I applied it to
> every new kernel out.
> 
> Without this patch, a nice=19 busy-looping process is given
> 15% of CPU cycles when there is a busy-looping nice=0 process. 
> [...]

I think it's simpler to change NICE_TO_TICKS() macro in sched.c


Bye.

