Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161077AbWHAKHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161077AbWHAKHq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 06:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbWHAKHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 06:07:46 -0400
Received: from gimli.datakultur.com ([212.28.216.234]:59094 "EHLO
	gimli.datakultur.com") by vger.kernel.org with ESMTP
	id S932616AbWHAKHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 06:07:45 -0400
From: Hans Eklund <hans@rubico.se>
Reply-To: hans@rubico.se
Organization: Rubico AB
To: David Brownell <david-b@pacbell.net>
Subject: Re: Block request processing for MMC/SD over SPI bus
Date: Tue, 1 Aug 2006 12:08:27 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608011208.27143.hans@rubico.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David.

First, my original post on LKML on the subject of MMC/SD over SPI framwork:

http://lkml.org/lkml/2006/8/1/71

I began developing a driver for MMC access over SPI on the Analog Devices 
Blackfin DSPs, running uClinux this spring. However, since then the blackfin 
uClinux has moved from kernel version 2.6.12 to 2.6.16 with the unified SPI 
framework. Also, a platform spi driver for the ADI Blackfin was recently 
written. I released my driver to the Blackfin uClinux community a few weeks 
ago and my plans was to move over to the SPI framwork using the platform 
driver instead of low level blackfin SPI related code.

As you can see om my LKML post, my driver covers(at first stage) everything 
from low level SPI commands and block device insertion to the request 
processing(since i at first could not connect to the MMC subsystem). Now, 
Russel King believes that you may have written a SPI to MMC subsytem driver. 
Correct? If so, whats the status on your driver?

My current goal was to make my driver platform independent and then(if 
possible) connect to the MMC subsystem which i, at this point is not too 
familiar with.
 
regards

Hans Eklund
Rubico AB - http://www.rubico.se
Sweden.
