Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWDZU5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWDZU5e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 16:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWDZU5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 16:57:34 -0400
Received: from mail.windriver.com ([147.11.1.11]:10965 "EHLO mail.wrs.com")
	by vger.kernel.org with ESMTP id S932463AbWDZU5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 16:57:33 -0400
Message-ID: <444FDEBB.90409@windriver.com>
Date: Wed, 26 Apr 2006 16:57:31 -0400
From: martin rogers <martin.rogers@windriver.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel pause during boot?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Apr 2006 20:57:32.0681 (UTC) FILETIME=[09B7EF90:01C66974]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I am trying to figure out why a kernel is pausing, until a key is typed on
the (serial) console, whenever a kernel module fails to load.

A module is failing to load (doesn't matter why- can't register a device b/c
the minor number is already taken), and the boot seemingly pauses until
a key is hit- or at least, the console seems paused in some manner.

I waited a long time and there appears to be no timeout.

A second module once failed to load for a different reason and the behaviour
was the same.

I don't know what statements that ran in the module, as a result of the 
failure
to load, that might explain the apparent pause.

Hopefully what I've  described will trigger someone's memory?

TIA!!!

Martin Rogers
Wind River

