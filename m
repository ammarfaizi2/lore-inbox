Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314753AbSELP5L>; Sun, 12 May 2002 11:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSELP5L>; Sun, 12 May 2002 11:57:11 -0400
Received: from ip68-6-164-6.sd.sd.cox.net ([68.6.164.6]:13252 "EHLO
	rei.moonkingdom.net") by vger.kernel.org with ESMTP
	id <S314753AbSELP5H>; Sun, 12 May 2002 11:57:07 -0400
Date: Sun, 12 May 2002 08:57:03 -0700
From: Marc Wilson <msw@cox.net>
To: linux-kernel@vger.kernel.org
Subject: Re: IRQ > 15 for Athlon SMP boards
Message-ID: <20020512155703.GG3142@moonkingdom.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3CDE48CC.9050003@nospam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2002 at 07:49:48PM +0900, Hugh wrote:

<deleted>

> The symptom as you can see is that IRQ > 15, which does not seem
> normal.  I checked this with 2.4.18-pre6aa1 and 2.4.18-pre8ac1.
> The results were the same.  The consequence is that X does not
> start because of an error that reads like
> 
> =============================================================
> (WW) MGA No matching device section for instance (BusID PCI:1:5:0) found
> (EE) No devices detected
> ==================================================================

<shrug> Make sure that the Device section for the Matrox card specifies the
correct BusID.  If it's set incorrectly it definately won't work... if you
don't set it at all it may or may not work.  Better to be explicit.

Been there, done that with the mga driver.

-- 
Marc Wilson
msw@cox.net

