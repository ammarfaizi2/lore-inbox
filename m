Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWE3BHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWE3BHx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWE3BHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:07:53 -0400
Received: from quechua.inka.de ([193.197.184.2]:32476 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1751307AbWE3BHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:07:52 -0400
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make sysctl obligatory except under CONFIG_EMBEDDED
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <200605292334.k4TNYgKg029556@terminus.zytor.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1Fksi6-0003Tm-00@calista.eckenfels.net>
Date: Tue, 30 May 2006 03:07:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin <hpa@zytor.com> wrote:
> This patch makes sysctl non-optional unless EMBEDDED is set.  There
> are a number of interfaces exposed via sysctl, enough that it has to
> be considered core kernel functionality at this point.

is this to help the user to configure the kernel or is it to remove
complexity (you just introduced some)

Gruss
Bernd
