Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbTCJQVA>; Mon, 10 Mar 2003 11:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261354AbTCJQVA>; Mon, 10 Mar 2003 11:21:00 -0500
Received: from poup.poupinou.org ([195.101.94.96]:33549 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S261353AbTCJQU7>; Mon, 10 Mar 2003 11:20:59 -0500
Date: Mon, 10 Mar 2003 17:31:34 +0100
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: psmouse.c: lost syncronization
Message-ID: <20030310163134.GA28136@poup.poupinou.org>
References: <20030310075340.GA22851@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030310075340.GA22851@triplehelix.org>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 11:53:40PM -0800, Joshua Kwan wrote:
> I've talked about this before, but i have some more details now..
> 
> psmouse.c: Lost synchronization, throwing 1 bytes away.
> 
> This only happens when an application is monitoring any part of 
> /proc/acpi. It varies between 1 and two bytes.
> 
> Why might this be?
> 

The Embedded Controller (from ACPI point of view) may be in the
same chip as for the keyboard controller, I guess.

Cheers,


-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
