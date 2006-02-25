Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932661AbWBYEBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661AbWBYEBD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 23:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932662AbWBYEBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 23:01:01 -0500
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:25738 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932661AbWBYEBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 23:01:00 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Extra keycodes
Date: Fri, 24 Feb 2006 23:00:58 -0500
User-Agent: KMail/1.9.1
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
References: <20060223175328.GA25482@srcf.ucam.org>
In-Reply-To: <20060223175328.GA25482@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602242300.58815.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 12:53, Matthew Garrett wrote:
> Hi,
> 
> Several laptops have keys that are intended to show battery status. In 
> order to present a consistent view to userspace, it would be nice to 
> have a standard keycode to map them to. linux/input.h doesn't currently 
> provide anything appropriate. What's the correct way of allocating 
> another keycode?
> 

Just post a patch adding it to input.h and we'll discuss... Who is intended
user? What interface is expected to be used (evdev)?

-- 
Dmitry
