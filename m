Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424586AbWKKRMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424586AbWKKRMI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 12:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424587AbWKKRMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 12:12:08 -0500
Received: from bay0-omc2-s24.bay0.hotmail.com ([65.54.246.160]:64039 "EHLO
	bay0-omc2-s24.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1424586AbWKKRMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 12:12:06 -0500
Message-ID: <BAY20-F93BA813AFE56E3A6BFE4DD8F60@phx.gbl>
X-Originating-IP: [80.178.105.247]
X-Originating-Email: [yan_952@hotmail.com]
From: "Burman Yan" <yan_952@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Proper patch posting question
Date: Sat, 11 Nov 2006 19:12:02 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 11 Nov 2006 17:12:06.0153 (UTC) FILETIME=[837BCF90:01C705B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I made a patch that replaces kmalloc+memset with kzalloc. The changes are in 
many
different places in the kernel, but most of them are trivial. The whole 
patch is about
360Kb. The less trivial parts that make more changes than just replacing 
kmalloc with
kzalloc and removing the memset are in different patches that I will send to 
the proper
maintainers.
My question is what would be the right way to post the trivial changes?
The way I see, I have a few options:
1) Post the entire patch on lkml
2) Split the patch into subsystems and post the smaller parts on lkml
3) Send the patch to trivial@kernel.org

Thank you in advance
Yan Burman

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

