Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265920AbUFOUeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265920AbUFOUeT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265945AbUFOUeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:34:19 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:36229 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265943AbUFOUeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:34:17 -0400
Date: Tue, 15 Jun 2004 22:35:02 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Helge Hafting vs. make menuconfig help
Message-ID: <20040615203502.GA2686@ucw.cz>
References: <20040615140206.A6153@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040615140206.A6153@beton.cybernet.src>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 02:02:06PM +0000, Karel Kulhavý wrote:
> Hello
> 
> Helge Hafting says that CONFIG_INPUT is about HID in general.
> make menuconfig help in 2.4.25 says that CONFIG_INPUT is about USB HID only.
> 
> This is 1:1. I would like to know what the truth is. Please add your
> opinions, I'll make a statistics and then evaluate the probable truth.
> Thank you.

Both are right. In 2.6, CONFIG_INPUT is used for all Human Input
Devices. In 2.4, though, only USB drivers use it. Get out of ancient
times, and look at 2.6 - it makes much more sense.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
