Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268984AbUJKNvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268984AbUJKNvM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 09:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268981AbUJKNvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 09:51:11 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:35265 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S268959AbUJKNtW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 09:49:22 -0400
Message-ID: <416A8F5F.6000000@drzeus.cx>
Date: Mon, 11 Oct 2004 15:49:19 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040919)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: MMC performance
References: <416A68E5.6080608@drzeus.cx> <20041011131919.B19175@flint.arm.linux.org.uk>
In-Reply-To: <20041011131919.B19175@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>Only if you can reliably know how many bytes you've tranferred when
>an error occurs.  Without that, the only safe way to do a write is
>sector by sector.
>
>  
>
What would happen if we failed the entire request? Rewriting a few 
sectors is harmless. Or will it break in more exotic ways?

Rgds
Pierre

