Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVFRND0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVFRND0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 09:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVFRND0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 09:03:26 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:21137 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S262110AbVFRNDW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 09:03:22 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Nick Warne <nick@linicks.net>
Subject: Re: 2.6.12 udev hangs at boot
Date: Sat, 18 Jun 2005 14:03:41 +0100
User-Agent: KMail/1.8.1
References: <200506181332.25287.nick@linicks.net>
In-Reply-To: <200506181332.25287.nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506181403.41212.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 Jun 2005 13:32, you wrote:
> Hi All,
>
> 2.6.12, GCC 3.4.4 on Slackware 10 base
>
> New 2.6.12 build hangs at initialising udev dynamic device directory on
> boot. I used make oldconfig from 2.6.11.12, and all the new changes I
> selected N, all bar nvidia FB support (I built several times, as I have a
> GeForce4 card, so suspected the nvidia FB support at first and turned off).
>
> 2.6.11.12 works perfect.
>
> I have just spent an hour or so investigating, but I am none the wiser.
>
> Ideas what could be causing this?

I had this problem because I was running an ancient version of udev (0.34, 
versus 0.58, at the time..). Try upgrading udev if it's out of date.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
