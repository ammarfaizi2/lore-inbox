Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265337AbUBISAL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 13:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265338AbUBISAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 13:00:10 -0500
Received: from [217.157.19.70] ([217.157.19.70]:29447 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S265337AbUBISAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 13:00:05 -0500
Date: Mon, 9 Feb 2004 18:00:02 +0000 (GMT)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: Arjan van de Ven <arjanv@redhat.com>
cc: linux-kernel@vger.kernel.org, <linux-raid@vger.kernel.org>
Subject: Re: New mailing list for 2.6 Medley RAID (Silicon Image 3112 etc.)
 BIOS RAID development
In-Reply-To: <20040209121144.GA24503@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.40.0402091756380.13341-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Feb 2004, Arjan van de Ven wrote:

> It doesn't really belong there.

I didn't really know about how initramfs was supposed to work, now I've
read up on it and I agree that it is the best solution.

I'll do the ataraid detection userside, but I am still not sure whether
some additions to the device mapper might be needed.

For Medley RAID it's pretty straightforward to map striped sets, but how
to deal with ataraids like Highpoint where they use non-standard zone
models for the RAID0 sets?

// Thomas

