Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWABOGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWABOGu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 09:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWABOGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 09:06:50 -0500
Received: from rtr.ca ([64.26.128.89]:37811 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750736AbWABOGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 09:06:49 -0500
Message-ID: <43B93375.1020701@rtr.ca>
Date: Mon, 02 Jan 2006 09:06:45 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Ralf_M=FCller?= <ralf@bj-ig.de>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, linux-ide@vger.kernel.org
Subject: Re: Kernel panic with 2.6.15-rc7 + libata1 patch
References: <43B724BA.90405@bj-ig.de> <43B7EA0A.7040805@bj-ig.de>	<20060101145702.GV3811@stusta.de> <43B806C7.5000607@bj-ig.de>
In-Reply-To: <43B806C7.5000607@bj-ig.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Müller wrote:
>
> A further problem is that calling "hdparm -C" _always_ give "drive state 
> is:  standby" - even when the disks are clearly active. Maybe this 
> indicates something to you.

MMmm.. yes, it does that here, too.
This is probably a bug somewhere in the libata passthru code,
or in the HDIO_* translation code.

Cheers
