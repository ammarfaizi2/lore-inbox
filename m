Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262860AbVAQT6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbVAQT6d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 14:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbVAQT6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 14:58:33 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:53655 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262860AbVAQT6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 14:58:23 -0500
Date: Mon, 17 Jan 2005 14:58:15 -0500
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
Message-ID: <20050117195815.GA22064@bittwiddlers.com>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org>
	<200501122242.51686.dtor_core@ameritech.net>
	<20050114230637.GA32061@bittwiddlers.com>
	<200501142031.10119.dtor_core@ameritech.net>
	<20050117195628.GA6704@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117195628.GA6704@ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
X-Delivery-Agent: TMDA/1.0.3 (Seattle Slew)
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
X-Primary-Address: mharrell@bittwiddlers.com
Reply-To: Matthew Harrell 
	  <mharrell-dated-1106423899.0d105b@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

: 
: I expect the problem to be coming from the fact that the keyboard
: controller uses ports 0x60 and 0x64, not 0x66 as ACPI tries to tell us
: here.
: 

Interesting - hadn't noticed that.  Is there an easy solution around it that
doesn't entail turning off acpi?

-- 
  Matthew Harrell                          I don't suffer from insanity - 
  Bit Twiddlers, Inc.                       I enjoy every minute of it.
  mharrell@bittwiddlers.com     
