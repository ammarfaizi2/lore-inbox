Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262869AbVF3GUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262869AbVF3GUK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 02:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbVF3GUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 02:20:10 -0400
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:35418 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262860AbVF3GTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 02:19:33 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Driver core patches for 2.6.13-rc1
Date: Thu, 30 Jun 2005 01:19:26 -0500
User-Agent: KMail/1.8.1
Cc: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
References: <20050630060206.GA23321@kroah.com>
In-Reply-To: <20050630060206.GA23321@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506300119.27306.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 June 2005 01:02, Greg KH wrote:
> Here are some small patches for the driver core.  They fix a bug that
> has caused some people to see deadlocks when some drivers are unloaded
> (like ieee1394), and add the ability to bind and unbind drivers from
> devices from userspace (something that people have been asking for for a
> long time.)
> 

Please don't until all buses are either audited or prepared to handle
"surprise" disconnects.

-- 
Dmitry
