Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWHKSEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWHKSEN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 14:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWHKSEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 14:04:13 -0400
Received: from lixom.net ([66.141.50.11]:64455 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1750910AbWHKSEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 14:04:11 -0400
Date: Fri, 11 Aug 2006 13:00:13 -0500
To: Linas Vepstas <linas@austin.ibm.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, Jens Osterkamp <Jens.Osterkamp@de.ibm.com>,
       James K Lewis <jklewis@us.ibm.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/4]: powerpc/cell spidernet ethtool -i version number info.
Message-ID: <20060811180013.GB6550@pb15.lixom.net>
References: <20060811170337.GH10638@austin.ibm.com> <20060811171117.GL10638@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060811171117.GL10638@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 12:11:17PM -0500, Linas Vepstas wrote:

> This patch adds version information as reported by 
> ethtool -i to the Spidernet driver.

Why does a driver that's in the mainline kernel need to have a version
number besides the kernel version?

I can understand it for drivers like e1000 that Intel maintain outside
of the kernel as well. But spidernet is a fully mainline maintained
driver, right?


-Olof
