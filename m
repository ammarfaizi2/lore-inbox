Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbVDFOid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbVDFOid (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 10:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVDFOid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 10:38:33 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:30731 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S262217AbVDFOic
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 10:38:32 -0400
From: Joe Button <joe@joebutton.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1: Mouse stopped working
Date: Wed, 6 Apr 2005 15:44:56 +0100
User-Agent: KMail/1.7.2
References: <200504061319.39431.vger.kernel.org@joebutton.co.uk> <4253E938.4040306@aitel.hist.no>
In-Reply-To: <4253E938.4040306@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504061544.57029.joe@joebutton.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 April 2005 14:50, Helge Hafting wrote:
> Joe Button wrote:
> >My mouse stopped working in x.org with 2.6.12-rc1. Problem is still there
> > in 2.6.12-rc2. Works on 2.6.11.x with same .config (except for make
> > oldconfig / defaults).
>
> Yes, but it may have moved to mouse1 or some such.
> Do you have a fancy keyboard with a wheel (perhaps a
> volume control) on it?  That may have become
> a "mouse" now.

Aha, /dev/input/mouse1 works. Thanks Helge and Benoit. No fancy keyboard, 
wheels etc so I don't know why it's moved.

Aside: I guess this sort of thing's why people keep complaining about the 2.6 
series not being 'stable' enough. Not a huge deal here though.

