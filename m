Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130488AbRBMGzU>; Tue, 13 Feb 2001 01:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130521AbRBMGzK>; Tue, 13 Feb 2001 01:55:10 -0500
Received: from www.lahn.de ([213.61.112.58]:16706 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S130488AbRBMGzA>;
	Tue, 13 Feb 2001 01:55:00 -0500
Date: Mon, 12 Feb 2001 09:06:42 +0100 (CET)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: <pmhahn@titan.lahn.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: WOL failure after shutdown
In-Reply-To: <3A874C51.5030207@nistix.com>
Message-ID: <Pine.LNX.4.33.0102120859431.2469-100000@titan.lahn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Feb 2001, James Brents wrote:

> Sorry, I wrote that in a hurry. Its a 3Com PCI 3c905C Tornado. I can
> successfully use wakeonlan if I power off the machine immeadiatly after
> turning it on. Using the shutdown command, which it will when I need it
> to power back up, it will not work.
Look at the page of Donald Becker at
http://cesdis.gsfc.nasa.gov/linux/drivers/vortex.html
Last time there was a small program to reactivate the D3-ACPI state which
is necessary to wake your nic. I think it's calles "pci-config.c"

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

