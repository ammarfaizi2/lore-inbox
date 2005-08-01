Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbVHAS0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVHAS0V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 14:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVHAS0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 14:26:18 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:62173
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261157AbVHASZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 14:25:19 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: <lists@dresco.co.uk>
Cc: <linux-kernel@vger.kernel.org>,
       "'hdaps devel'" <hdaps-devel@lists.sourceforge.net>,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>,
       "'Dave Hansen'" <dave@sr71.net>
Subject: RE: [Hdaps-devel] Re: IBM HDAPS, I need a tip.
Date: Mon, 1 Aug 2005 12:25:04 -0600
Message-ID: <003801c596c6$574e08b0$a20cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <42EE650A.60109@dresco.co.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>Thanks to development of the driver from some nice guys, we
> are able to
> >>get data from the accelerometer. There is one problem. How do we
> >>calibrate the values that are outputed from the userspace?
> All PC's get
> >>a different value, and we can't really find the best
> solution. What is
> >>the scientific and smartest way to do this?
> >>
> >>
>
> I'm not convinced we need to get so hung up on the calibration. Sure,
> each laptop has somewhat different resting values - but surely what
> we're looking for is any rate of change in either the X or Y values
> thats over a predefined 'safe' threshold? (I would imagine that we're
> only going to find that safe threshold from some imaginative testing
> once we've got the head parking sorted....)
>
> Just my 2p worth,
> Jon.

hard drive parking was already sorted out. We have a script that does this
and works great parking the heads.

The problem here is that we have 10 different models.

One will have 20 as X and the others will have 500 as x. Some will increment
in 20 when you move them 45Deg, and some will increment 50.

How can you determine from an shake, to a fall?

.Alejandro

