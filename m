Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWCKSuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWCKSuI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 13:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWCKSuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 13:50:08 -0500
Received: from rtr.ca ([64.26.128.89]:12726 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751064AbWCKSuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 13:50:06 -0500
Message-ID: <44131BC9.5020800@rtr.ca>
Date: Sat, 11 Mar 2006 13:49:45 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: psmouse - disable autoresync
References: <200603110023.38863.dtor_core@ameritech.net>
In-Reply-To: <200603110023.38863.dtor_core@ameritech.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> Automatic resynchronization in psmouse driver causes problems on some
> hardware so disable it by default for now. People with KVM switches
> that require resync can still enable it via module parameter or sysfs
> attribute.

Shouldn't the default be the other way round..
Existing *compatible* behaviour by default,
and those who need it can do psmouse.resync_time=0

????????????????
