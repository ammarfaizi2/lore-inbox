Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTH0Oub (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 10:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263450AbTH0Oub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 10:50:31 -0400
Received: from www.13thfloor.at ([212.16.59.250]:29909 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S263452AbTH0Oua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 10:50:30 -0400
Date: Wed, 27 Aug 2003 16:50:41 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Laurent =?iso-8859-1?Q?Hug=E9?= <laurent.huge@wanadoo.fr>
Cc: Stuart MacDonald <stuartm@connecttech.com>,
       "'Russell King'" <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Reading accurate size of recepts from serial port
Message-ID: <20030827145041.GC26817@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Laurent =?iso-8859-1?Q?Hug=E9?= <laurent.huge@wanadoo.fr>,
	Stuart MacDonald <stuartm@connecttech.com>,
	'Russell King' <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
References: <005c01c36bdd$8ae58d30$294b82ce@stuartm> <200308261723.04683.laurent.huge@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200308261723.04683.laurent.huge@wanadoo.fr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 05:23:04PM +0200, Laurent Hugé wrote:
> Le Mardi 26 Août 2003 16:22, Stuart MacDonald a écrit :
> > I may be mistaken, but I believe that Windows serial drivers work the
> > same way; so whatever you meant by your previous comment that you can
> > get what you want under windows, either you can get the same thing
> > under linux, or windows doesn't behave like you think it does.
> I actually don't know how it works, because I didn't contrive it (I can only 
> rely on what has been told to me by the people whom has done it). I'm only in 
> charge of porting it to Linux.
> Anyway, I'm on the way to another solution (by using some property of CCSDS 
> segments, and see what happens).

hmm, why not do simple framing ...
[length]<data>[length]<data> ....

best,
Herbert

> -- 
> Laurent Hugé.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
