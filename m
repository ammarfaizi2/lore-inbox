Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262798AbVD2Phn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262798AbVD2Phn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 11:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbVD2Phn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 11:37:43 -0400
Received: from web60214.mail.yahoo.com ([209.73.178.117]:13200 "HELO
	web60214.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262798AbVD2Phj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 11:37:39 -0400
Message-ID: <20050429153738.78730.qmail@web60214.mail.yahoo.com>
Date: Fri, 29 Apr 2005 11:37:38 -0400 (EDT)
From: john doe <catcowcrow@yahoo.ca>
Subject: Re: ATA port addresses
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the prompt reply!

I'll look at this option closer.  Is there a way to
bypass the IDE driver though?  I was hoping the code
would run at the driver level for security reasons.  I
would like to write the command to the device
directly.

> Its architecture and board dependent. Linux will let
> you issue IDE
> taskfile command blocks via ioctls so you can avoid
> poking the hardware
> (and poking the hardware will upset the ide
> driver..)


______________________________________________________________________ 
Post your free ad now! http://personals.yahoo.ca
