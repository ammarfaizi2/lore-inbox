Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbUDDPHG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 11:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUDDPHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 11:07:06 -0400
Received: from vvv.conterra.de ([212.124.44.162]:27029 "EHLO conterra.de")
	by vger.kernel.org with ESMTP id S262416AbUDDPHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 11:07:04 -0400
Message-ID: <40702492.8050603@conterra.de>
Date: Sun, 04 Apr 2004 17:06:58 +0200
From: Dieter Stueken <stueken@conterra.de>
Organization: con terra GmbH
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata transport attributes
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Since libata is leaving SCSI in 2.7, I would rather not add superfluous stuff like this at all.
> Further, you can already retrieve the information you export with _zero_ new code.

does this include informations about the drives SMART status, too?

The smartmotools (http://smartmontools.sourceforge.net/) won't work
with libata until some "passthrough" command gets implemented :-(
Will this be available soon (or even working now), or do I have to
wait until 2.7?

This is the main reason, that prevents me from switching to SATA now!
Just when writing these lines, I'm analyzing some prefail indications
from one of my 300G PATA disks via SMART. I have no problem, to replace
that disk now, but when running those disks blindly without SMART over
SATA, I certainly would loose those 300G very soon...

So, can you give us an idea of a time line about those things, please?

Dieter.
-- 
Dieter Stüken, con terra GmbH, Münster
     stueken@conterra.de
     http://www.conterra.de/
     (0)251-7474-501
