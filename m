Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268317AbUJDQer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268317AbUJDQer (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 12:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268296AbUJDQeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 12:34:04 -0400
Received: from host50.200-117-131.telecom.net.ar ([200.117.131.50]:1470 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S268271AbUJDQdp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 12:33:45 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: Mathieu Segaud <matt@minas-morgul.org>
Subject: Re: 2.6.9-rc3-mm2
Date: Mon, 4 Oct 2004 13:33:39 -0300
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20041004020207.4f168876.akpm@osdl.org> <200410041239.05591.norberto+linux-kernel@bensa.ath.cx> <87k6u6mp5z.fsf@barad-dur.crans.org>
In-Reply-To: <87k6u6mp5z.fsf@barad-dur.crans.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410041333.39531.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Mathieu Segaud wrote:
> I had read on reiserfs@ that reiser4-parse-options-reduce-stack-usage.patch
> solved this problem. My mistake.

No, it's my mistake! :)

We were talking about two different patches. After reading your post, I tried 
a look up on reiser4 and 4KSTACKS got my attention. 

reiser4-parse-options-reduce-stack-usage.patch seems to fix the 4KSTACKS 
issue; perhaps you'll want to revert reiser4-4kstacks-fix.patch and test it.

Best regards,
Norberto
