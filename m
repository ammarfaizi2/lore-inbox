Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965318AbWH2Unz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965318AbWH2Unz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 16:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965320AbWH2Unz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 16:43:55 -0400
Received: from gw.goop.org ([64.81.55.164]:37313 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S965318AbWH2Uny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 16:43:54 -0400
Message-ID: <44F48F7D.4050908@goop.org>
Date: Tue, 29 Aug 2006 12:03:25 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Zachary Amsden <zach@vmware.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
Subject: Why set ORIG_EAX(%esp) to -1 in arch/i386/kernel/entry.S:error_code?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There doesn't seem much point; nothing seems to use it on the 
trap-handling paths.  Is it a historical left-over?

    J

