Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbVLYOiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVLYOiO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 09:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbVLYOiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 09:38:14 -0500
Received: from aeimail.aei.ca ([206.123.6.84]:30421 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S1750821AbVLYOiN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 09:38:13 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: Mark Lord <lkml@rtr.ca>
Subject: Re: 2.6.15-rc6 - Success with ICH5/SATA + S.M.A.R.T.
Date: Sun, 25 Dec 2005 09:37:54 -0500
User-Agent: KMail/1.8.3
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0512241830010.2700@p34> <43ADDD34.9020101@rtr.ca>
In-Reply-To: <43ADDD34.9020101@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200512250937.55140.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 December 2005 18:43, Mark Lord wrote:
>  >smartmontools is going to have to be updated
> 
> What for?
> 
> Use "smartctl -d ata /dev/sda"

Its not perfect:

grover:/poola/home/ed# smartctl -d ata /dev/sda
smartctl version 5.34 [x86_64-unknown-linux-gnu] Copyright (C) 2002-5 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

smartctl has problems but hddtemp works

grover:/poola/home/ed# hddtemp /dev/hda
/dev/hda: Maxtor 6Y160P0: 25°C
grover:/poola/home/ed# hddtemp /dev/sda
/dev/sda: Maxtor 6L250S0: 29°C

Ed Tomlinson


