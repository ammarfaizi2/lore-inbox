Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTIUPo0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 11:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbTIUPoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 11:44:25 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:20119 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262439AbTIUPoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 11:44:24 -0400
To: linux-kernel@vger.kernel.org
Subject: New System freezes for seconds to minutes then recovers [2.4.23-pre4]
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 21 Sep 2003 11:44:06 -0400
Message-ID: <87smmqp2nt.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just set up a new system with an Asus P4P800 and P4 with HT. Under
2.4.23-pre4 the system freezes occasionally for a few seconds, sometimes for
as long as a minute. Then it recovers as if nothing happened. No printks,
nothing to explain what happened. When the machine is frozen it doesn't
respond to pings, but when it recovers it sends all the icmp echo responses
for the time it was down.


At first I thought it was related to the i810_audio, since it seemed to happen
consistently whenever I started playing a new track in xmms. But I've removed
the i810_audio module and it's still happening.

I thought it could be related to the sk98 ethernet driver even though I wasn't
using it but i've removed that module too. I haven't rebooted since removing
these modules though.

The only "suspicious" things left are Hyperthreading, and the SATA controller.

Have other people been reporting similar problems? 

-- 
greg

