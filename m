Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130416AbRCEUfh>; Mon, 5 Mar 2001 15:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130417AbRCEUf1>; Mon, 5 Mar 2001 15:35:27 -0500
Received: from mail.mediaways.net ([193.189.224.113]:14440 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S130416AbRCEUfU>; Mon, 5 Mar 2001 15:35:20 -0500
Date: Mon, 5 Mar 2001 21:19:10 +0100
From: Walter Hofmann <walter.hofmann@physik.stud.uni-erlangen.de>
To: Jim Breton <jamesb-kernel@alongtheway.com>
Cc: Wade Hampton <whampton@staffnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: eject weirdness on NEC disc changer, kernel 2.4.2
Message-ID: <20010305211910.A13054@frodo.uni-erlangen.de>
In-Reply-To: <20010304205046.15690.qmail@alongtheway.com> <3AA3DE27.E34DD4B3@staffnet.com> <20010305190930.2759.qmail@alongtheway.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010305190930.2759.qmail@alongtheway.com>; from jamesb-kernel@alongtheway.com on Mon, Mar 05, 2001 at 07:09:30PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Mar 2001, Jim Breton wrote:

> I have had a similar problem in the past where, for example, after
> cancelling a burn session with cdrecord I am unable to eject the disc.
> However that was on kernel 2.2.x and using "real" scsi (not ide-scsi).

This was a bug in cdrecord which used generic scsi access to lock the
drive. The kernel cannot notice this. AFAIK this bug is fixed in
cdrecord.

Walter
