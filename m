Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760630AbWLFOFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760630AbWLFOFM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 09:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760628AbWLFOFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 09:05:11 -0500
Received: from mail.aiken.cz ([82.208.4.206]:55868 "EHLO mail.aiken.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760630AbWLFOFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 09:05:10 -0500
Message-ID: <4576CE08.9080703@arpartner.cz>
Date: Wed, 06 Dec 2006 15:04:56 +0100
From: Lukas Jelinek <luk@arpartner.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc4
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Suggestion for kevent
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm interested in kevents and related things. I think it isn't a bad 
idea to incorporate more event kinds into the kevent implementation. Namely:
- processes (exitting/stopping/tracing)
- threads (ditto)
- futexes (for mutexes, semaphores and conditional variables)
- special communication events (such as on modem lines - see 
ioctl(TIOCMIWAIT,...))
- whatever can be found useful

Please consider this idea. Such solution may be useful for developers of 
large and complex applications. Thanks.

Regards,

Lukas Jelinek

