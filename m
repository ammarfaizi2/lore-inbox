Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267353AbUBTBU2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 20:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267619AbUBTBU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 20:20:27 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:2314 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S267353AbUBTBT7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 20:19:59 -0500
Date: Fri, 20 Feb 2004 02:20:00 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: HOWTO use udev to manage /dev
Message-ID: <20040220012000.GC29822@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040219185932.GA10527@kroah.com> <20040219191636.GC10527@kroah.com> <Pine.LNX.4.58.0402191918440.688@pervalidus.dyndns.org> <20040219230749.GA15848@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040219230749.GA15848@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 03:07:49PM -0800, Greg KH wrote:
> Did you build udev using glibc or klibc?  I used klibc and it worked
> just fine, as udev and udevd does not need /dev/null to work, unlike
> programs built against glibc.

 Downside is that when klibc is used, udev cannot link with DBUS libraries
linked with glibc. 

-- 
Tomasz Torcz               "Never underestimate the bandwidth of a station 
zdzichu@irc.-nie.spam-.pl    wagon filled with backup tapes." -- Jim Gray 
