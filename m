Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161598AbWJDQsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161598AbWJDQsL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161601AbWJDQsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:48:11 -0400
Received: from xenotime.net ([66.160.160.81]:4517 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161598AbWJDQsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:48:09 -0400
Date: Wed, 4 Oct 2006 09:49:34 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Miguel Ojeda Sandonis <maxextreme@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18 V8] drivers: add LCD support
Message-Id: <20061004094934.b780c8c5.rdunlap@xenotime.net>
In-Reply-To: <20061004180615.6a81e4c7.maxextreme@gmail.com>
References: <20061004180615.6a81e4c7.maxextreme@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2006 18:06:15 +0000 Miguel Ojeda Sandonis wrote:

> miguelojeda-2.6.18-add-lcd-display-support.patch.v8
> 
> Andrew, I think this can be the final review.
> Nomenclature changed as requested. Please apply.
> 
> 
> Brief
> -----
> 
>  - Adds a "auxdisplay/" folder in "drivers/" for auxiliary display drivers.
>  - Adds a LCD class for registering LCD devices.
>  - Adds support for the ks0108 LCD Controller as a device driver.
>  (uses lcddisplay class and parport interface)

Couldn't you make the class be "auxdisplay" also?

>  - Adds support for the cfag12864b LCD as a device driver.
>  (uses ks0108 LCD Controller driver)
>  - Adds a new ioctl() magic number/range (0xFF) in the list for the cfag12864b device.
>  - Adds the usual Documentation, ABI, includes, Makefiles, Kconfigs, MAINTAINERS, CREDITS...

---
~Randy
