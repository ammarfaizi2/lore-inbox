Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbTIRBQO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 21:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262922AbTIRBQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 21:16:14 -0400
Received: from [63.205.85.133] ([63.205.85.133]:60890 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S262918AbTIRBQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 21:16:13 -0400
Date: Wed, 17 Sep 2003 18:25:11 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: John R Moser <jmoser5@student.ccbc.cc.md.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Small security option
Message-ID: <20030918012511.GI1086@gaz.sfgoth.com>
References: <Pine.A32.3.91.1030917204729.33040A-200000@student.ccbc.cc.md.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.A32.3.91.1030917204729.33040A-200000@student.ccbc.cc.md.us>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John R Moser wrote:
> Some sysadmins like to disable the other boot devices and password-protect
> the bios.  Good, but if the person can pass init=, you're screwed. 

1. If you have physical access to the machine you're screwed anyway (boot
   from a CD... if BIOS is password-protected just temporarily put the
   harddrive in another machine)

2. In the relatively rare cases that you have physical access to the console
   but not the machine (locked down kiosks or secured lab settings) you can
   (and should) secure the bootloader.  This prevents any malicious command
   line options (think "root=my.nfs.server:/toolkit") not just "init=".

So this patch is basically pointless.

-Mitch
