Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268940AbRIMLna>; Thu, 13 Sep 2001 07:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269481AbRIMLnV>; Thu, 13 Sep 2001 07:43:21 -0400
Received: from mail.zmailer.org ([194.252.70.162]:56840 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S268940AbRIMLnL>;
	Thu, 13 Sep 2001 07:43:11 -0400
Date: Thu, 13 Sep 2001 14:42:53 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: tushar korde <tushar_k5@rediffmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: suggest project
Message-ID: <20010913144253.T11046@mea-ext.zmailer.org>
In-Reply-To: <20010913071731.5671.qmail@mailweb18.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010913071731.5671.qmail@mailweb18.rediffmail.com>; from tushar_k5@rediffmail.com on Thu, Sep 13, 2001 at 07:17:31AM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2001 at 07:17:31AM -0000, tushar  korde wrote:
> sir,
>       i am begineer to kernel programming.i want  to make  a driver for
> any device such that specs for that device are available or any suitable
> project in kernel programming . i have time constraint of 3-4 months.
> i want to pick up a project which will open the doors of kernel programming .
>                      so can u pls suggest me any suitable project .

   Find out why Linux PS/2 keyboard and mouse drivers don't support
   disconnect, and reconnect of said devices.   Then fix things so
   that keyboard can be replugged at any time, and it gets into
   sensible state, same with the mouse.

   This is especially serious nuisance while running X-window system,
   which of course uses raw keyboard events.  (But that should not matter
   at the low-level driver, which should handle the reconnect issue.)

> thanks in advance
> 
> yours truly
> tushar korde

/Matti Aarnio
