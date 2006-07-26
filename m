Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbWGZFRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbWGZFRX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 01:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbWGZFRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 01:17:23 -0400
Received: from web37913.mail.mud.yahoo.com ([209.191.124.108]:33196 "HELO
	web37913.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030387AbWGZFRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 01:17:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=oHZLHGsY4dhjja8U0R2qg2hj/h+12uvXDUUiHsVJL1Jdtl3k5xaHNEQ+sgpdommuSY6cu3RjyW/hWMwLDFCOIMIrXD2Ta0UIa1nbqWzOpZHUsEcEa2+iLAAC1EalrzCFBBqhnHTbReiyVaO9vNUmiJdo8GnwQCLka3pu5wlDx0E=  ;
Message-ID: <20060726051721.18126.qmail@web37913.mail.mud.yahoo.com>
Date: Tue, 25 Jul 2006 22:17:21 -0700 (PDT)
From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] OMAP: Add keypad driver #2
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: akpm@osdl.org, juha.yrjola@solidboot.com, tony@atomide.com,
       ext-timo.teras@nokia.com, r-woodruff2@ti.com,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <d120d5000607251332ma001b27teaf0f07d6c122362@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> 
> Hi Komal,
> 
> The driver needs to handle failures in input_register_device() and
> unwind initialization properly. Also you do not need to do double
> negation of the value when calling input_report_key() because it will
> do it for you.
> 
> Also you might consider setting up keycodetable, keycodesize, etc in
> the input device - this way you can change keymap at runtime via
> ioctls.

Thanx for the review. I will update the driver and submit to list soon.


---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
