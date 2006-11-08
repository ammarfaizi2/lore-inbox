Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422764AbWKHUCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422764AbWKHUCt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422770AbWKHUCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:02:49 -0500
Received: from 147.175.241.83.in-addr.dgcsystems.net ([83.241.175.147]:884
	"EHLO tmnt04.transmode.se") by vger.kernel.org with ESMTP
	id S1422764AbWKHUCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:02:48 -0500
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Jesper Juhl'" <jesper.juhl@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: How to compile module params into kernel?
Date: Wed, 8 Nov 2006 21:02:42 +0100
Message-ID: <02fd01c70370$d9af6700$020120ac@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: AccDaOXJxT0pzTfXTCSwYbObkAdLAQAB7rsQ
In-Reply-To: <9a8748490611081105j5ca1d24ahd49c6d9ea7d980d3@mail.gmail.com>
X-OriginalArrivalTime: 08 Nov 2006 20:02:43.0427 (UTC) FILETIME=[DA229B30:01C70370]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Jesper Juhl [mailto:jesper.juhl@gmail.com] 
> 
> On 08/11/06, Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > Instead of passing a module param on the cmdline I want to 
> compile that
> > into
> > the kernel, but I can't figure out how.
> >
> > The module param I want compile into kernel is
> > rtc-ds1307.force=0,0x68
> >
> > This is for an embeddet target that doesn't have loadable module
> > support.
> >
> You could edit the module source and hardcode default values.
> 

Yes, but I don't want to do that since it makes maintance
harder.

 Jocke

