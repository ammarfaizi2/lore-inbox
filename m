Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261505AbSJUQhm>; Mon, 21 Oct 2002 12:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261506AbSJUQhm>; Mon, 21 Oct 2002 12:37:42 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:14493
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S261505AbSJUQhl>; Mon, 21 Oct 2002 12:37:41 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200210211643.g9LGhks17929@www.hockin.org>
Subject: Re: eepro100 -- Sending a multicast list set command from a timer routine
To: akropel1@rochester.rr.com (Adam Kropelin)
Date: Mon, 21 Oct 2002 09:43:46 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021021120355.GA4065@www.kroptech.com> from "Adam Kropelin" at Oct 21, 2002 08:03:55 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Oct 21, 2002 at 05:56:35PM +0900, Miles Bader wrote:
> > Starting with 2.5.44 I'm getting tons of messages like the following
> > printed on the console:
> > 
> >    eth0: Sending a multicast list set command from a timer routine, m=0, j=50143, l=49360.
> 
> Same here... 

A change to use the new netif_msg_xxx interface must have gone in.  Shortly
there will be a patch which cleans up the randomish messages it spews out.
Nothing to worry about.

Tim
