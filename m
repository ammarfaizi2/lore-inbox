Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVBGUDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVBGUDY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 15:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVBGUBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 15:01:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:58042 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261302AbVBGUAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 15:00:47 -0500
Date: Mon, 7 Feb 2005 12:00:41 -0800
From: Chris Wright <chrisw@osdl.org>
To: =?iso-8859-1?Q?Lorenzo_Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>
Cc: Chris Wright <chrisw@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Filesystem linking protections
Message-ID: <20050207120041.Z24171@build.pdx.osdl.net>
References: <1107802626.3754.224.camel@localhost.localdomain> <20050207111235.Y24171@build.pdx.osdl.net> <1107805243.3754.240.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <1107805243.3754.240.camel@localhost.localdomain>; from lorenzo@gnu.org on Mon, Feb 07, 2005 at 08:40:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lorenzo Hernández García-Hierro (lorenzo@gnu.org) wrote:
> About what things it can break, I haven't noticed any issue on it (at
> least regarding grSecurity or OpenWall), but of course I would
> appreciate a lot any information on them, so, I could report to the
> developers that are currently using this in their own solutions.

In the past it has broken atd and courier.  The hardlink restrictions
had to be relaxed in both cases.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
