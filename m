Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129375AbRASFZP>; Fri, 19 Jan 2001 00:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129807AbRASFZG>; Fri, 19 Jan 2001 00:25:06 -0500
Received: from nat-pool-e.redhat.com ([199.183.24.18]:57610 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129375AbRASFYx>; Fri, 19 Jan 2001 00:24:53 -0500
Date: Fri, 19 Jan 2001 00:24:10 -0500
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Is there a Crystal 4299 sound driver?
Message-ID: <20010119002410.C15679@nostromo.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <4461B4112BDB2A4FB5635DE1995874320223D5@mail0.myrio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4461B4112BDB2A4FB5635DE1995874320223D5@mail0.myrio.com>; from torrey.hoffman@myrio.com on Thu, Jan 18, 2001 at 05:47:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Torrey Hoffman (torrey.hoffman@myrio.com) said: 
> Does anyone know of a driver for the Crystal 4299 sound chip?

It's not something there's one particular sound driver for (it's just
an ac97 codec chip, as you saw). Most likely you want to use something
like the i810_audio or via82cxxx_audio drivers. What does lspci say
on your machine?

Bill
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
