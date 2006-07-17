Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWGQNe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWGQNe7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 09:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWGQNe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 09:34:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:20311 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750774AbWGQNe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 09:34:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qel7ULZocO2c3hMt6RFRVsKt4tJVteeeXUweco17zShgPf89cY+QG5lkHr7Yxo6uPMlExpyW6FTUFYGfLBZfVyeXfZmNrw754GKtAcYSSbvX0xGEQBcMaIIkT/Z0Itdg67XIL/cq491j9mEmaGuhXy245COkkapOvG1U+BSQdBI=
Message-ID: <81b0412b0607170634p298ab59p3c52b8c9c0cc7661@mail.gmail.com>
Date: Mon, 17 Jul 2006 15:34:56 +0200
From: "Alex Riesen" <raa.lkml@gmail.com>
To: "Mauro Carvalho Chehab" <mchehab@infradead.org>
Subject: Re: oops in bttv
Cc: "Alex Riesen" <fork0@users.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com
In-Reply-To: <1152962993.26522.18.camel@praia>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060711204940.GA11497@steel.home>
	 <1152962993.26522.18.camel@praia>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/06, Mauro Carvalho Chehab <mchehab@infradead.org> wrote:
> > What I did was to call settings of the flashplayer and press on the
> > webcam symbol there. The system didn't crash, just this oops:
> >
> > BUG: unable to handle kernel NULL pointer dereference at virtual address 0000006
> > 5
> Hmm... Are you using it on what machine? It might be related to an
> improper handling at compat32 module.

32bit. PIV, 2Gb, highmem on.
