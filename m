Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265155AbTLKROO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 12:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265164AbTLKROO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 12:14:14 -0500
Received: from avs.xs4all.nl ([213.84.37.64]:2944 "EHLO airraid.toptracker.com")
	by vger.kernel.org with ESMTP id S265155AbTLKRON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 12:14:13 -0500
Message-ID: <3FD8A5E4.9050206@van.staalduijnen.net>
Date: Thu, 11 Dec 2003 18:14:12 +0100
From: Arjan van Staalduijnen <arjan@van.staalduijnen.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marco Roeland <marco.roeland@xs4all.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Compile failure when 'Preemptible Kernel' is disabled
 in 2.6.0-test11.
References: <3FD86820.2010507@bioscoopagenda.net> <20031211133341.GA14573@localhost>
In-Reply-To: <20031211133341.GA14573@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Roeland wrote:
>>[1.] Compile failure when 'Preemptible Kernel' is disabled.
> It has nothing to do with 'preemptible'!
Correct, but switching that option was just the way for me to trigger or 
'untrigger' this problem.

> This is a known compiler bug for RedHat's gcc 2.96 version. It has
> difficulty casting 'unsigned long long's! Try this, it applies against
> 2.6.0-test8 and later.
=== patch snipped ===
Applying the patch indeed solved this compile failure. I can now turn 
off the Preemtible kernel feature while still being able to compile the 
code.

Thanks,

Arjan

