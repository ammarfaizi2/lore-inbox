Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVAMDpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVAMDpd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 22:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVAMDou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 22:44:50 -0500
Received: from smtp819.mail.sc5.yahoo.com ([66.163.170.5]:8804 "HELO
	smtp819.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261420AbVAMDmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 22:42:54 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
Date: Wed, 12 Jan 2005 22:42:51 -0500
User-Agent: KMail/1.6.2
Cc: Roey Katz <roey@sdf.lonestar.org>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org> <200501110239.33260.dtor_core@ameritech.net> <Pine.NEB.4.61.0501130315500.11711@sdf.lonestar.org>
In-Reply-To: <Pine.NEB.4.61.0501130315500.11711@sdf.lonestar.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501122242.51686.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 January 2005 10:19 pm, Roey Katz wrote:
> Dmitry,
> 
> I have placed the results of the patched 2.6.9-rc2-bk2 kernel at the 
> following address:
> 
>    http://roey.freeshell.org/mystuff/kernel/*-20050112
> 
> As expected, the system was unresponsive to keyboard input.

And what if you do not compile PS/2 mouse support in? Is keyboard still
dead?

> Regarding your mouse question:
> How do I test the mouse if they keyboard does not work (is there some 
> way to output the contents of /dev/psaux on startup? I'm not sure anymore 
> what file the mouse data appears in, too)
> 

Install GPM and try moving your mouse after booting into runlevel 3 -
if cursor moves mouse works.

-- 
Dmitry
