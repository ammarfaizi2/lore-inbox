Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268182AbTAKWJP>; Sat, 11 Jan 2003 17:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268183AbTAKWJO>; Sat, 11 Jan 2003 17:09:14 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:11807 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S268182AbTAKWIt>;
	Sat, 11 Jan 2003 17:08:49 -0500
Date: Sat, 11 Jan 2003 23:16:17 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Michael Dreher <dreher@math.tu-freiberg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hda has changed heads
Message-ID: <20030111221617.GA20341@win.tue.nl>
References: <200301112249.11624.dreher@math.tu-freiberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301112249.11624.dreher@math.tu-freiberg.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 10:49:11PM +0100, Michael Dreher wrote:

> Basically, I dont care about the new number of heads,

Right

> but now lilo complains like this (it did not complain before):

Try giving LILO the keyword linear or lba32.
Then it does not need any idea about the geometry at bootloader
install time.

Andries
