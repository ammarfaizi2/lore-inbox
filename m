Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263545AbTC3LGr>; Sun, 30 Mar 2003 06:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263546AbTC3LGr>; Sun, 30 Mar 2003 06:06:47 -0500
Received: from cs180132.pp.htv.fi ([213.243.180.132]:31634 "EHLO
	devil.pp.htv.fi") by vger.kernel.org with ESMTP id <S263545AbTC3LGq>;
	Sun, 30 Mar 2003 06:06:46 -0500
Subject: Re: Bad interactive behaviour in 2.5.65-66 (sched.c)
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: Robert Love <rml@tech9.net>
Cc: Peter Lundkvist <p.lundkvist@telia.com>, akpm@digeo.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
In-Reply-To: <1048980204.13757.17.camel@localhost>
References: <3E8610EA.8080309@telia.com>
	 <1048980204.13757.17.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049023130.4713.6.camel@devil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 30 Mar 2003 14:18:51 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-30 at 01:23, Robert Love wrote:
> I wonder if the reniced X is a factor?

I had some interactivity problems with X reniced to -10. It seemed to me
that X was pre-empting the clients and flushing changes to screen too
quickly. It was probably losing out on some screen update optimizations.
I took out the renice and now the system behaves much better.

	MikaL

