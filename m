Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVBMGqC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVBMGqC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 01:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVBMGqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 01:46:02 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:61083 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261210AbVBMGp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 01:45:58 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Roey Katz <roey@sdf.lonestar.org>
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
Date: Sun, 13 Feb 2005 01:45:55 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org> <200501122242.51686.dtor_core@ameritech.net> <Pine.NEB.4.61.0502121749290.25663@sdf.lonestar.org>
In-Reply-To: <Pine.NEB.4.61.0502121749290.25663@sdf.lonestar.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502130145.55761.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 February 2005 12:50, Roey Katz wrote:
> Hello again Dmitry,
> 
> is there anything new about this issue? any fixes in the kernel?
> If you want, I can continue doing the test/debug cycle as before.
> 

Hi Roey,

I have been looking over your logs one more time and it looks like
there is a small change in i8042 init sequence that I have overlooked
before.

Could you please tell me if booting with i8042.nomux option helps your
keyboard?

Thanks!

-- 
Dmitry
