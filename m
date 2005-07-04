Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVGDXeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVGDXeJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 19:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVGDXeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 19:34:09 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:16616 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261733AbVGDXeF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 19:34:05 -0400
Date: Tue, 5 Jul 2005 01:30:18 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Cc: Juha Laiho <Juha.Laiho@iki.fi>, Andrew Hutchings <info@a-wing.co.uk>,
       linux-kernel@vger.kernel.org, lars.vahlenberg@mandator.com,
       vinay kumar <b4uvin@yahoo.co.in>, jgarzik@pobox.com
Subject: Re: sis190
Message-ID: <20050704233018.GA4496@electric-eye.fr.zoreil.com>
References: <22391136.1120301527301.JavaMail.www@wwinf1518>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22391136.1120301527301.JavaMail.www@wwinf1518>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal CHAPPERON <pascal.chapperon@wanadoo.fr> :
[...]
> I can not make other tries before Monday, but i'll take a
> look at the media management after...
> 
> BTW, can you remove the following printks from the patch ?
> The printks in interrupt functions make dmesg unusuable, 
> and the stuff in sis190_get_drvinfo triggers a kernel oops
> when the module is loaded (null pointer assignment).

Done.

Can you check if there is a regression in sis190-000.patch available at
http://www.zoreil.com/~romieu/sis190/20050704-2.6.13-rc1/patches ?

If it works and you want some entertainment, you can apply sis190-010.patch
+ sis190-020.patch and experience with ethtool/mii-tool. 

There is a tarball as well:
http://www.zoreil.com/~romieu/sis190/20050704-2.6.13-rc1.tar.bz2

--
Ueimor
