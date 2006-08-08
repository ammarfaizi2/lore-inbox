Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbWHHPBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbWHHPBl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbWHHPBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:01:41 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:30945 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S932594AbWHHPBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:01:40 -0400
Date: Tue, 8 Aug 2006 17:01:36 +0200
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Suspend on Dell D420
Message-ID: <20060808150136.GA16272@uio.no>
References: <20060804162300.GA26148@uio.no> <200608051108.01180.rjw@sisk.pl> <20060806115043.GA30671@uio.no> <200608081604.00665.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200608081604.00665.rjw@sisk.pl>
X-Operating-System: Linux 2.6.16trofastxen on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 04:04:00PM +0200, Rafael J. Wysocki wrote:
> Please apply the appended patch to the SMP kernel and try the following:
>
> [...]
>
> I think (1) will work and (2) will not, but let's see. :-)

Actually, both worked just fine. The first one (testproc) gave me EPERM on
the actual write call according to echo, but I guess that's just a side
effect of sloppy test code :-)

/* Steinar */
-- 
Homepage: http://www.sesse.net/
