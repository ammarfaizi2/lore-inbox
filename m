Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbUK2Mkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbUK2Mkv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 07:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbUK2MjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 07:39:06 -0500
Received: from levante.wiggy.net ([195.85.225.139]:24534 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S261704AbUK2Mgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 07:36:33 -0500
Date: Mon, 29 Nov 2004 13:36:29 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Jim Nelson <james4765@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about /dev/mem and /dev/kmem
Message-ID: <20041129123629.GP31995@wiggy.net>
Mail-Followup-To: Jim Nelson <james4765@verizon.net>,
	linux-kernel@vger.kernel.org
References: <41AA9E26.4070105@verizon.net> <20041129093937.GN31995@wiggy.net> <41AAFE4E.7010308@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41AAFE4E.7010308@verizon.net>
User-Agent: Mutt/1.5.6+20040722i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Jim Nelson wrote:
> Isn't that /proc/sys/kernel/cap-bound?

yes, it is.

> And what stops an attacker who's already gained root from doing a "cat "0" 
> > /proc/sys/kernel/cap-bound" ?

The fact that you are not allowed to change the cap-bound settings with
that specific bitmask. 

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
