Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268840AbUHLW2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268840AbUHLW2D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 18:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268837AbUHLW2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 18:28:02 -0400
Received: from mail.gmx.de ([213.165.64.20]:22947 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268845AbUHLW01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 18:26:27 -0400
X-Authenticated: #1725425
Date: Fri, 13 Aug 2004 00:44:56 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-Id: <20040813004456.09b0841b.Ballarin.Marc@gmx.de>
In-Reply-To: <411BDD11.8070400@tmr.com>
References: <20040807001427.GA10890@ucw.cz>
	<200408070001.i7701PSa006663@burner.fokus.fraunhofer.de>
	<1091899593.20043.14.camel@kryten.internal.splhi.com>
	<411BDD11.8070400@tmr.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004 17:11:45 -0400
Bill Davidsen <davidsen@tmr.com> wrote:

> 
> But they *don't* map to consistent device names. All hot pluggable 
> devices seem to map to the next available name. Looking at one of my 
> utility systems, it has IDE drives mapped by Redhat with ide-scsi, real 
> SCSI drives, a couple of flash card slots mapped to SCSI, and a USB 
> device, all in the /dev/sdX namespace. And in the order in which they 
> were detected (connected, in other words).
> 
> Joerg hasn't made it any better, but it isn't great anyway. I recommend 
> a script to do discovery and make symlinks somewhere to names which 
> always match the same device.
> 

That's exactly what udev allows you to do (among a lot of other things).

Marc
