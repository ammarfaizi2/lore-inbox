Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVAGV2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVAGV2R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVAGV1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:27:18 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:52692 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261634AbVAGVZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:25:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Z6uMRCcUNCs7u6ciM4irMUYaIQpodhzUPPjtUPgUw4TSYvAZ/JqHS/sunBVYu+nJ+T3OP/sfeNzVBJntyhqLplvdEasgkgFjpMxvd5zmaARcb+v0ofbJ3eg2ZqDHgFpPEGUznCQOGiFISdogDFbOYAAFghamuoc/JAW0VzrM9f8=
Message-ID: <297f4e0105010713254b6e0678@mail.gmail.com>
Date: Fri, 7 Jan 2005 22:25:14 +0100
From: Ikke <ikke.lkml@gmail.com>
Reply-To: Ikke <ikke.lkml@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: kobject_uevent
In-Reply-To: <297f4e01050107065060e0b2ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <297f4e01050107065060e0b2ad@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been working a bit on the kobject_uevent stuff, and got a
prototype system working (well, almost) which takes kernel's uevents,
and sends them to the DBUS system bus so other software can (ab)use
them.
I'll add more uevents later, once I understand the system completely.
I'm a little confused by the use of KOBJ_* stuff in
include/linux/kobject_uevent.h and the string representation of them
in lib/kobject_uevent.c, which means people must edit 2 files if they
want to add new events?

More information on my little work here [1]

Regards, Ikke


[1] http://blog.eikke.com/index.php/ikke/2005/01/07/kernel_events_to_dbus
