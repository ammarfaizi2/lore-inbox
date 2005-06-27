Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbVF0WgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVF0WgF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 18:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVF0WgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 18:36:05 -0400
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:3453 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262014AbVF0Wf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 18:35:56 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Date: Mon, 27 Jun 2005 17:35:50 -0500
User-Agent: KMail/1.8.1
Cc: Mike Bell <kernel@mikebell.org>, Greg KH <greg@kroah.com>
References: <20050624081808.GA26174@kroah.com> <20050625234305.GA11282@kroah.com> <20050627071907.GA5433@mikebell.org>
In-Reply-To: <20050627071907.GA5433@mikebell.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506271735.50565.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 June 2005 02:19, Mike Bell wrote:
> On Sat, Jun 25, 2005 at 04:43:05PM -0700, Greg KH wrote:
> > So no, I'm not going to be submitting this.  But what it is, is a nice
> > proof-of-concept for people who "just can't live without a in-kernel
> > devfs" to show that it can be done in less than 300 lines of code, and
> > only 6 hooks (2 functions in 3 different places) in the main kernel
> > tree.  That is managable outside of the main kernel for years, with
> > almost little to no effort.
> 
> Except that it isn't.
> 
> The "everything in the root" model just doesn't seem to work. It's been
> so long since I used linux without devfs I hadn't thought about how
> things like ALSA and the input subsystem have gone beyond supporting
> device nodes in a subdirectory to actually requiring device nodes to be
> in a subdirectory.

AFAIK there is no requirement in input subsystem that devices should be
created under /dev/input. When devfs is activated they are created there
by default, but that's it.
  
-- 
Dmitry
