Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751742AbWHMX6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbWHMX6k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 19:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbWHMX6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 19:58:40 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:22129 "EHLO
	asav09.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1751742AbWHMX6j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 19:58:39 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AT0KACtZ30SBUQ
From: Dmitry Torokhov <dtor@insightbb.com>
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: 2.6.18-rc4-mm1
Date: Sun, 13 Aug 2006 19:58:36 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060813012454.f1d52189.akpm@osdl.org> <44DF10DF.5070307@gmail.com>
In-Reply-To: <44DF10DF.5070307@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608131958.37140.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 August 2006 07:45, Maciej Rutecki wrote:
> Andrew Morton napisał(a):
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
> 
> I have problem with my keyboard. I have no error in dmesg and syslog,
> but it doesn't work. I read google and try "i8042.nomux", but it didn't
> help.
> 
> I enclose dmesg with "i8042.debug=1" option and my config.
> 
> Maybe I forgot something in config?
> 

You have keyboard configured as a module in your .config but I do not
see it trying to attach to the keyboard serio port. Make sure the module
is loaded.

-- 
Dmitry
