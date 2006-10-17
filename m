Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161031AbWJQJp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161031AbWJQJp7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 05:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423202AbWJQJp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 05:45:59 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:38771 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161031AbWJQJp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 05:45:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Lz7GccrW7LWr9eJ8bAaa18XMalCawDTSU0llPAr3fMiWUD5sUFoiu7yAbjx7dTtYaPrmcKR5E8mu6TLpUzRxStOAJDZDscGmDdmsdxezQtiNhdIdg4ErFsKQXvC0coKDAZVRGtIunL5opI+K1+HzjSEtThnTFVTxG1pr2TGOTD4=
Message-ID: <3420082f0610170245x1a3fa82ft88246b25cab09942@mail.gmail.com>
Date: Tue, 17 Oct 2006 14:45:57 +0500
From: "Irfan Habib" <irfan.habib@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: getting a return from a system call
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to build a system call which returns a float, and is defined as :
asmlinkage float sys_ph_pinfo(int pid, int mode)

but in a user level program every time, I evaluate it, I always get a return 0!
How do I capture the return of a system call?

Also is it possible that a system call return a structure or array?
Will that be available in user space? My hunch is that this is not
possible, as kernel memory space is disjoint form the user memory
space, but just for information.

Regards,
Irfan
