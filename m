Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273529AbRIYUjX>; Tue, 25 Sep 2001 16:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273537AbRIYUjN>; Tue, 25 Sep 2001 16:39:13 -0400
Received: from [195.211.46.202] ([195.211.46.202]:13073 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S273529AbRIYUiz>;
	Tue, 25 Sep 2001 16:38:55 -0400
X-Spam-Filter: check_local@serv02.lahn.de by digitalanswers.org
Date: Mon, 24 Sep 2001 21:19:39 +0200 (CEST)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: <pmhahn@titan.lahn.de>
To: Taral <taral@taral.net>
Cc: khromy <khromy@lnuxlab.ath.cx>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10 problems with X + USB mouse
In-Reply-To: <20010923223531.A9228@taral.net>
Message-ID: <Pine.LNX.4.33.0109242117330.3942-100000@titan.lahn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Sep 2001, Taral wrote:

> > 5 button Microsoft IntelliMouse?
> A clone of, yes. I wonder what changed in 2.4.10 to break this?
Part of Vojtech Pavlik INPUT Layer got merged, i.e.,
drivers/input/mousedev.c, which now does ImExPS/2 emulation instead of
plain PS/2 emulation.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

