Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266926AbTBCQyJ>; Mon, 3 Feb 2003 11:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266932AbTBCQyJ>; Mon, 3 Feb 2003 11:54:09 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:52367 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266926AbTBCQyI>;
	Mon, 3 Feb 2003 11:54:08 -0500
Date: Mon, 3 Feb 2003 17:00:07 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Seamus <assembly@gofree.indigo.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPU throttling??
Message-ID: <20030203170007.GA10090@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Seamus <assembly@gofree.indigo.ie>, linux-kernel@vger.kernel.org
References: <02ea01c2cb9b$9e90bbd0$15c809c6@PCJOERI01> <1044291313.17360.4.camel@taherias.sre.tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1044291313.17360.4.camel@taherias.sre.tcd.ie>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 04:55:13PM +0000, Seamus wrote:

 > Would it be possible to throttle cpu when machine is in idle mode in
 > Linux? or is it purely a BIOS and motherboard functionality.
 > 
 > As you know some modern laptops in order to save power, throttle cpu
 > (lower the cpu clock cycles per sec) when in idle mode.

ACPI does this, CPUFreq does this, and if you're really lucky,
there are some APM implementations that do it.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
