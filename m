Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265275AbTBJWHS>; Mon, 10 Feb 2003 17:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265333AbTBJWHS>; Mon, 10 Feb 2003 17:07:18 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:51439 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S265275AbTBJWHR>;
	Mon, 10 Feb 2003 17:07:17 -0500
Date: Mon, 10 Feb 2003 23:16:55 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Dan Parks <Dan.Parks@camotion.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Keystrokes, USB, and Latency
Message-ID: <20030210221655.GA3875@win.tue.nl>
References: <1044907523.1438.475.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1044907523.1438.475.camel@localhost>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 03:05:22PM -0500, Dan Parks wrote:

> ...  However, if the user presses caps
> lock, num lock, or scroll lock (everything else is ok), it ALWAYS misses
> 7-8 milliseconds.

You didnt mention a kernel version, and details very much depend on it.
But you may look into LED setting, and e.g. whether interrupts are
disabled during LED setting.
