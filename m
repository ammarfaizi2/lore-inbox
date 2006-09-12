Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWILVjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWILVjv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 17:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWILVjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 17:39:51 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:65224 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751434AbWILVju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 17:39:50 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andreas Steinmetz <ast@domdv.de>
Subject: Re: uswsusp oddity
Date: Tue, 12 Sep 2006 23:39:39 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <4506BF56.6000309@domdv.de>
In-Reply-To: <4506BF56.6000309@domdv.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609122339.40550.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 12 September 2006 16:08, Andreas Steinmetz wrote:
> I just tried uswsusp 0.2 and there is a strange problem (2.6.17.8, x86_64):
> 
> The swap device used for suspend must be the first swap device,
> otherwise suspend fails.

This is a known issue, happens also in swsusp.  It should be fixed in 2.6.18.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
