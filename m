Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133040AbRECT50>; Thu, 3 May 2001 15:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133099AbRECT5R>; Thu, 3 May 2001 15:57:17 -0400
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:31962 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id <S133097AbRECTzN>; Thu, 3 May 2001 15:55:13 -0400
Date: Thu, 3 May 2001 22:55:10 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: <makisara@kai.makisara.local>
To: Mark Hounschell <markh@compro.net>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: raw tape device support???
In-Reply-To: <3AF17679.DCD39840@compro.net>
Message-ID: <Pine.LNX.4.33.0105032252040.597-100000@kai.makisara.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 May 2001, Mark Hounschell wrote:

>  Sorry if this isn't the correct place for this question. Is there or
> will there
> ever be raw tape device access. I'm trying to port an app from Dec unix
> and at
> least there the app requires /dev/rmt** (raw device). I've read in the
> archives
> about how to bind a block device to a raw device using the raw command
> but the
> tape dev (/dev/st*) is a char device and the command doesn't work on
> char devices.
> So I'm trying to figure out to get the same effect as /dev/rmt* does on
> the dec
> box in a linux environment.

You can just use the device /dev/st* (or /dev/nst*). They are raw
(character) devices. If your app needs to find the devices with names
/dev/rmt*, you can make new device nodes or use links.

	Kai


