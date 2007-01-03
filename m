Return-Path: <linux-kernel-owner+w=401wt.eu-S932099AbXACUpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbXACUpH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 15:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbXACUpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 15:45:07 -0500
Received: from stinky.trash.net ([213.144.137.162]:49276 "EHLO
	stinky.trash.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932099AbXACUpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 15:45:05 -0500
Message-ID: <459C15C7.4080000@trash.net>
Date: Wed, 03 Jan 2007 21:44:55 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Josefsson <gandalf@wlug.westbo.se>
CC: Chuck Ebbert <76306.1226@compuserve.com>,
       "MalteSch@gmx.de" <MalteSch@gmx.de>, linux-kernel@vger.kernel.org,
       berni@birkenwald.de, netfilter-devel@lists.netfilter.org
Subject: Re: [BUG] panic 2.6.20-rc3 in nf_conntrack
References: <200701020228_MC3-1-D707-115D@compuserve.com> <Pine.LNX.4.58.0701030913470.8163@tux.rsn.bth.se>
In-Reply-To: <Pine.LNX.4.58.0701030913470.8163@tux.rsn.bth.se>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Josefsson wrote:
> Check the return value of nfct_nat() in device_cmp(), we might very well
> have non NAT conntrack entries as well.
> 
> Signed-off-by: Martin Josefsson <gandalf@wlug.westbo.se>

Applied, thanks Martin.
