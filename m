Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUFORt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUFORt1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 13:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265807AbUFORsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 13:48:55 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:53120 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S265805AbUFORqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 13:46:52 -0400
Date: Tue, 15 Jun 2004 17:46:51 +0000
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: AT Keyboard (was: Helge Hafting vs. make menuconfig help)
Message-ID: <20040615174651.A6965@beton.cybernet.src>
References: <20040615140206.A6153@beton.cybernet.src> <20040615141039.GF20632@lug-owl.de> <20040615142040.B6241@beton.cybernet.src> <20040615144127.GG20632@lug-owl.de> <20040615172129.F6843@beton.cybernet.src> <20040615173210.GM20632@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040615173210.GM20632@lug-owl.de>; from jbglaw@lug-owl.de on Tue, Jun 15, 2004 at 07:32:10PM +0200
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In 2.4.x, the transition from "old-style" input drivers to new-style
> (Input API) was never finished. Instead, Input API was introduced, and
> HID devices reported their input to Input API, while old drivers still
> used all their old ways to deliver their input.

I (hopefully correctly) assume that one of the old ones is AT keyboard.

What happens when I press a key on keyboard and the application that
has the keyboard somehow on it's stdin reads a key? What happens between
the two events and how does it travel inside the kernel?

I know how the keys can be read from port 0x60 or whichever.

Cl<
