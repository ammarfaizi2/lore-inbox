Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTG1LbX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 07:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTG1LaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 07:30:20 -0400
Received: from home.wiggy.net ([213.84.101.140]:48267 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S261151AbTG1L3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 07:29:10 -0400
Date: Mon, 28 Jul 2003 13:44:24 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: fix 2 byte data leak due to padding
Message-ID: <20030728114424.GB5453@wiggy.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200307272019.h6RKJ1Et029763@hraefn.swansea.linux.org.uk> <3F249D42.4010003@aros.net> <1059391969.15438.16.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059391969.15438.16.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Alan Cox wrote:
> sizeof(variable) can be suprising some times so I always use sizeof(type) out
> of habit. (Think sizeof(x) when X later becomes a pointer)

when X becomes a pointer and you use sizeof(type of what X points to)
you'll be in trouble anyway.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.

