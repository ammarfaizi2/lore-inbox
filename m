Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261419AbSJMIpZ>; Sun, 13 Oct 2002 04:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261424AbSJMIpZ>; Sun, 13 Oct 2002 04:45:25 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:22546 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261419AbSJMIpZ>;
	Sun, 13 Oct 2002 04:45:25 -0400
Message-Id: <5.1.0.14.2.20021013104231.00bbbf88@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 13 Oct 2002 10:48:21 +0200
To: "Joseph D. Wagner" <wagnerjd@prodigy.net>,
       "'David S. Miller'" <davem@redhat.com>
From: Mike Galbraith <efault@gmx.de>
Subject: RE: Strange load spikes on 2.4.19 kernel
Cc: <robm@fastmail.fm>, <hahn@physics.mcmaster.ca>,
       <linux-kernel@vger.kernel.org>, <jhoward@fastmail.fm>
In-Reply-To: <000f01c27294$438d5fa0$7443f4d1@joe>
References: <20021013.011344.58438240.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:40 AM 10/13/2002 -0500, Joseph D. Wagner wrote:
> > Not true.  While a block is being allocated on mounted
> > filesystem X on one cpu, a TCP packet can be being
> > processed on another processor and a block can be allocated
> > on mounted filesystem Y on another processor.
>
>Does anyone besides me notice that the more Dave and I argue the longer
>and longer the list of extenuating circumstances gets in order for Dave
>to continue to be right?

Nope.  You seem to think "threaded" means there can be no critical sections.

         -Mike


