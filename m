Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267637AbTBQXG7>; Mon, 17 Feb 2003 18:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267641AbTBQXG7>; Mon, 17 Feb 2003 18:06:59 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:18583 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S267637AbTBQXG6>; Mon, 17 Feb 2003 18:06:58 -0500
Date: Mon, 17 Feb 2003 18:16:44 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Patrick Finnegan <pat@purdueriots.com>
Subject: Re: Bug: usb-storage module
Message-ID: <20030217231644.GA1695@Master.Wizards>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Patrick Finnegan <pat@purdueriots.com>
References: <Pine.LNX.4.44.0302161815360.23692-200000@ibm-ps850.purdueriots.com> <20030216192441.A26961@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030216192441.A26961@one-eyed-alien.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2003 at 07:24:41PM -0800, Matthew Dharm wrote:
> Hrm... when was the cache probing introduced? I'll bet the device doesn't
> like that.
> 
> Matt
> 
The cache probing worked in 2.5.58. Nothing with usb-storage worked in 2.5.59
in 2.5.60 & 61 cache probing fails for me, but I can still read. Writing causes
a BUG() in usb-storage due to not being able to recover from some other error
(don't know what the error is though - the stack trace only shows scsi_eh)
although the data does get written

-- 
Murray J. Root

