Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbVLTHJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbVLTHJe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 02:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbVLTHJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 02:09:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10674 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750816AbVLTHJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 02:09:34 -0500
Date: Tue, 20 Dec 2005 02:09:22 -0500
From: Dave Jones <davej@redhat.com>
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Kernel interrupts disable at user level - RIGHT/ WRONG - Help
Message-ID: <20051220070922.GA5542@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Mukund JB." <mukundjb@esntechnologies.co.in>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <3AEC1E10243A314391FE9C01CD65429B223292@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B223292@mail.esn.co.in>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 12:27:13PM +0530, Mukund JB. wrote:
 > 
 > Dear Alan,
 > 
 > I want the contents of A, B, C, D registers of CMOS mapped registers.
 > But instead the driver gives the details about the bit masks of few of register A, B only.
 > The others are NOT available. 
 > 
 > I would also require to retrieve the day of the week info in RTC information. 
 > I tried the /dev/rtc but I don't get it there.

Use /dev/nvram instead.

		Dave
