Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbTGGRPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 13:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265076AbTGGRPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 13:15:17 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:53299 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264192AbTGGRPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 13:15:15 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Peter Berg Larsen <pebl@math.ku.dk>
Subject: Re: [PATCH] Synaptics: support for pass-through port (stick)
Date: Mon, 7 Jul 2003 12:31:15 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <Pine.LNX.4.40.0307071400140.28730-100000@shannon.math.ku.dk>
In-Reply-To: <Pine.LNX.4.40.0307071400140.28730-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307071231.16178.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 July 2003 07:09 am, Peter Berg Larsen wrote:
> On Mon, 7 Jul 2003, Peter Berg Larsen wrote:
>
> Replying to myself.
>
> > > button reporting (only left and right as I am not sure to which buttons
> > > up/down should be mapped),
> >
> > hmm. You dont know what the guest protocol, so you can't just | the
> > button information. However, reallity is that this will work for nearly
> > anybody now.
>
> This is not the greatest idea as the guest sometimes does not recieve the
> button release. This is bad only if the userdriver multiplex the
> micebuttons from different mice, because it would then seem as the user
> holds the button down.
>

So should we just get rid of all button multiplexing in kernel module and 
leave it to the userland (gpm/XFree)? Not trying to bail out, just want to 
find the best solution...

Dmitry
