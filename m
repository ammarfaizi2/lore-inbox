Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbULCPB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbULCPB2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 10:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbULCPB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 10:01:28 -0500
Received: from vvv.conterra.de ([212.124.44.162]:7081 "EHLO conterra.de")
	by vger.kernel.org with ESMTP id S262208AbULCPBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 10:01:25 -0500
Message-ID: <41B07FC3.9040506@conterra.de>
Date: Fri, 03 Dec 2004 16:01:23 +0100
From: Dieter Stueken <stueken@conterra.de>
Organization: con terra GmbH
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: libata-dev queue updated
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * ATA passthru (read: SMART support)

is it still unsafe to use passthru concurrently
to normal disk I/O, as stated earlier?

an other question:

will some "coldplug" be possible with SATA?

I currently may unload the sata module, exchange the disk(s)
and reload the module again. Works file, but instead I want
to exchange a single disk of my LVM system, while all other
disks are still active.

I found some advice, on how to do that with SCSI disks.
Will it be possible with SATA, too?

Dieter.
-- 
Dieter Stüken, con terra GmbH, Münster
     stueken@conterra.de
     http://www.conterra.de/
     (0)251-7474-501
