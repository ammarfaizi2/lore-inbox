Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWKDGWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWKDGWw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 01:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWKDGWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 01:22:52 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:56797 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S932367AbWKDGWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 01:22:52 -0500
Date: Fri, 3 Nov 2006 22:22:51 -0800
From: thockin@hockin.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: John <me@privacy.net>, linux-kernel@vger.kernel.org, linux.nics@intel.com
Subject: Re: Intel 82559 NIC corrupted EEPROM
Message-ID: <20061104062251.GA15100@hockin.org>
References: <454B7C3A.3000308@privacy.net> <454BF0F1.5050700@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454BF0F1.5050700@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2006 at 05:46:25PM -0800, H. Peter Anvin wrote:
> Basically, Auke wants you to throw away your NIC and/or motherboard. 
> Since you're effectively dead, the only damage you can do by disabling 
> the check has already been done.  This unfortunately seems to be fairly 
> common with e100, especially for the on-motherboard version, and you 
> basically have two options: either disable the check or write an offline 
> tool to reprogram the EEPROM.

I have a tool to write the eepro100 EEPROM.  Let me see if I can find it.
It even had all the default data coded, ready to restore a NIC to default.

However - back in the eepro100.c days, it was considered a warning only if
the EEPROM had a bad checksum.  There were two "supported" formats for the
EEPROM, one of which was just the MAC address.  And it worked!

Tim
