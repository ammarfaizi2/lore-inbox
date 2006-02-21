Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbWBUSeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbWBUSeX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 13:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWBUSeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 13:34:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:50405 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932545AbWBUSeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 13:34:14 -0500
Date: Tue, 21 Feb 2006 09:43:18 -0800
From: Greg KH <greg@kroah.com>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Tom Zanussi <zanussi@us.ibm.com>,
       linux-kernel@vger.kernel.org, axboe@suse.de, karim@opersys.com
Subject: Re: [PATCH, RFC] sysfs: relay channel buffers as sysfs attributes
Message-ID: <20060221174318.GB23018@kroah.com>
References: <20060219171748.GA13068@linux-sh.org> <20060219175623.GA2674@kroah.com> <20060219185254.GA13391@linux-sh.org> <17401.21427.568297.830492@tut.ibm.com> <20060220130555.GA29405@Krystal> <20060220171531.GA9381@linux-sh.org> <20060220173732.GA7238@Krystal> <20060221152102.GA20835@linux-sh.org> <20060221164852.GA6489@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221164852.GA6489@Krystal>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 11:48:53AM -0500, Mathieu Desnoyers wrote:
> The problem sits in how tracing is seen. To kernel hackers, it is seen as an
> interesting kernel debugging tool, while for the vast majority of LTTng
> users, it is seen as a useful system wide information gathering tool to debug
> _their_ system wide problems involving programs, librairies and drivers.

And as a debug tool, debugfs seems like the perfict place for it, as you
have just stated :)

And please, no matter what you decide on, do NOT put those files in
proc, as they have nothing to do with processes.

thanks,

greg k-h
