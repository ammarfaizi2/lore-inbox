Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWCVSOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWCVSOh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 13:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWCVSOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 13:14:37 -0500
Received: from canuck.infradead.org ([205.233.218.70]:19180 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932279AbWCVSOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 13:14:36 -0500
Message-ID: <442193F6.9030300@torque.net>
Date: Wed, 22 Mar 2006 13:14:14 -0500
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [GIT PATCH] pending SCSI updates for post 2.6.16
References: <1142956795.4377.19.camel@mulgrave.il.steeleye.com>	 <20060322083647.cc0ccdd4.rdunlap@xenotime.net> <1143047958.3633.17.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1143047958.3633.17.camel@mulgrave.il.steeleye.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Wed, 2006-03-22 at 08:36 -0800, Randy.Dunlap wrote:
> 
>>Can we get a SCSI_DEBUG link order change (or force it to not
>>built-in)?
> 
> 
> Yes ... but we need the maintainer to decide which option first.

James,
I'm happy to have scsi_debug link last, as Randy is suggesting.

I would prefer that to stopping it being built in. Another
possibility is that when it is built in, to default to
no devices (i.e. logical units) rather than one. However
Randy's suggestion is the simplest.

Signed-off-by: Douglas Gilbert <dougg@torque.net>

Doug Gilbert
