Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161345AbWAMEks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161345AbWAMEks (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 23:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWAMEks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 23:40:48 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:49448 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751398AbWAMEkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 23:40:47 -0500
Date: Thu, 12 Jan 2006 22:40:33 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: ide-cd turning off DMA when verifying DVD-R
In-reply-to: <5uoqr-Qq-7@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43C72F41.5060207@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
X-Accept-Language: en-us, en
References: <5ujmU-1UQ-665@gated-at.bofh.it> <5uoqr-Qq-7@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Syrjälä wrote:
> I think the drive just takes too long to recongize the disc. My 4163B has
> the same problem which is why I always close the tray manually or with
> eject -t and wait a while before mounting or burning the disc. Of course
> that won't help in your case. I guess the real fix would be to
> increase some ide-cd timeout.

I'm thinking the IDE code is too aggressive in assuming that the failure 
  is because of a DMA problem and disabling it.. Most likely all that's 
happening is the drive is taking a long time to complete the current 
command.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

