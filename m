Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWCaNbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWCaNbq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 08:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWCaNbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 08:31:46 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:45329 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932132AbWCaNbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 08:31:45 -0500
Date: Fri, 31 Mar 2006 15:31:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Clean up arch-overrides in linux/string.h
Message-ID: <20060331133135.GB12208@mars.ravnborg.org>
References: <20060331043345.GH31321@quicksilver.road.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331043345.GH31321@quicksilver.road.mcmartin.ca>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 11:33:45PM -0500, Kyle McMartin wrote:
> Some string functions were safely overrideable in lib/string.c, but
> their corresponding declarations in linux/string.h were not.

Whats wrong with a common prototype?
If an arch decide to #define a string function they can do this anyway.

	Sam
