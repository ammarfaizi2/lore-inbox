Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbVKFQuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVKFQuv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 11:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVKFQuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 11:50:51 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:8092 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932127AbVKFQuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 11:50:50 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [Fwd: [PATCH] [PNP][RFC] Suspend support for PNP bus.]
Date: Sun, 6 Nov 2005 11:50:44 -0500
User-Agent: KMail/1.8.3
Cc: drzeus-list@drzeus.cx, linux-kernel@vger.kernel.org, ambx1@neo.rr.com
References: <436B2819.4090909@drzeus.cx> <d120d5000511040812g1552b610o7523b727323364d1@mail.gmail.com> <20051104231500.6a9272d1.akpm@osdl.org>
In-Reply-To: <20051104231500.6a9272d1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511061150.46007.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 November 2005 02:15, Andrew Morton wrote:
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >
> > On 11/4/05, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > >
> > > You lost me... We have a scenario when a PNP driver is bound to a PNP
> > > device that does not support deactivation. Looking at the proposed PNP
> > > bus suspend code presence of such device will cause suspend process to
> > > fail. Are you saying this is what you want?
> > >
> > 
> > Ugh, scratch whatever I wrote earlier. Such devices should be marked
> > with RES_DO_NOT_CHANEG so everything is fine.
> > 
> > Sorry about the noise.
> 
> So...  You're OK with the patch as proposed?
> 

Yes I am.

-- 
Dmitry
