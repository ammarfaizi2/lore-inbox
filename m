Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVERHcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVERHcO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 03:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbVERHcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 03:32:13 -0400
Received: from main.gmane.org ([80.91.229.2]:18891 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262121AbVERHbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 03:31:53 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Date: Wed, 18 May 2005 09:23:16 +0200
Message-ID: <1mfpgkwlxtuqr.1d08qu3xvpbwn.dlg@40tude.net>
References: <41iyE-8mI-11@gated-at.bofh.it> <427KM-h4-9@gated-at.bofh.it> <42pRx-75A-19@gated-at.bofh.it> <42znJ-6x7-25@gated-at.bofh.it> <42zQL-70r-25@gated-at.bofh.it> <42CF0-YV-37@gated-at.bofh.it> <42GIH-4u3-31@gated-at.bofh.it> <42Jn3-6Qj-5@gated-at.bofh.it> <42KsY-7KW-33@gated-at.bofh.it> <E1DVga4-0001g7-4s@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-ull-23-118.44-151.net24.it
User-Agent: 40tude_Dialog/2.0.15.1
Cc: linux-hotplug-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2005 04:04:11 +0200, Bodo Eggert
<harvested.in.lkml@posting.7eggert.dyndns.org> wrote:

> Giuseppe Bilotta <bilotta78@hotpop.com> wrote:
> 
>> Is there a way to control the order in which modules get loaded? For
>> example, I usually blacklist the parport module and only load it when
>> I need it, thus freeing an IRQ (for audio, IIRC). If parport loads
>> automatically, it grabs the IRQ; if it loads after the IRQ is grabbed
>> already, it'll resort to polled mode. Can these things be controlled
>> without the blacklist?
> 
> Documentation/parport.txt

Thanks for saying RTFD nicely :)

> The rest should be configurable in /etc/mod{ules,probe}.conf

Thanks again.

-- 
Giuseppe "Oblomov" Bilotta

"Da grande lotterò per la pace"
"A me me la compra il mio babbo"
(Altan)
("When I grow up, I will fight for peace"
 "I'll have my daddy buy it for me")

