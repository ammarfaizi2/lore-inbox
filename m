Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265977AbUHIEqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265977AbUHIEqV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 00:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUHIEqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 00:46:21 -0400
Received: from home.bounceswoosh.org ([66.17.169.80]:7100 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S265977AbUHIEqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 00:46:20 -0400
Date: Sun, 8 Aug 2004 22:48:39 -0600
From: "Eric D. Mudama" <edmudama@bounceswoosh.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Paul Jakma <paul@clubi.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: libata: dma, io error messages
Message-ID: <20040809044839.GA18961@bounceswoosh.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Paul Jakma <paul@clubi.ie>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.60.0408061113210.2622@fogarty.jakma.org> <1091795565.16307.14.camel@localhost.localdomain> <4113A684.8050302@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4113A684.8050302@pobox.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug  6 at 11:40, Jeff Garzik wrote:
>libata does not (yet) retry cable errors, for example.  Paul, don't 
>automatically assume the disk is bad, try swapping cables.

In practice with large #s of drives, cable errors are a given, even
with good cables... eventually *something* is going to glitch, we see
it all the time in our testing, especially at elevated temperatures.

--eric


-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

