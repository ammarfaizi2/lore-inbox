Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268235AbUHKVZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268235AbUHKVZj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 17:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268233AbUHKVZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 17:25:39 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:63662 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S268235AbUHKVZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 17:25:28 -0400
Date: Wed, 11 Aug 2004 23:25:19 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Peter Schaefer <peter.schaefer@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [VIA-RHINE] Timeouts on EP-HDA3+ Motherboard
Message-ID: <20040811212519.GA22449@k3.hellgate.ch>
Mail-Followup-To: Peter Schaefer <peter.schaefer@gmx.de>,
	linux-kernel@vger.kernel.org
References: <41181BF7.6060002@gmx.de> <20040809215424.GA12237@k3.hellgate.ch> <4118A534.8050903@gmx.de> <20040810070651.GB11224@k3.hellgate.ch> <411AC46D.6080307@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411AC46D.6080307@gmx.de>
X-Operating-System: Linux 2.6.8-rc3-mm1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004 03:14:21 +0200, Peter Schaefer wrote:
> As this is a production machine i haven't had the balls to move to
> 2.6.8-rc3. Instead, i took only the via-rhine.c from 2.6.8-rc4-mm1
> applied your last patch to it and recompiled the module.

Odd. AFAIK 2.6.8-rc4-mm1 has all the patches merged. My most recent
patch was for mainline only.

> What should i say: It works! I wasn't able to trigger the error with
> my standard test (copying a 680MB ISO image from/to Samba shares in
> parallel). An this even with "large readwrite" enabled in smb.conf.

Cool. Thanks for the report.

>          (But perhaps you should update the drivers version number)

2.6.7 had 1.1.20-2.6. The driver in 2.6.8-rc4-mm1 is 1.2.0-2.6. The
driver in 2.6.8 (mainline) is patch-wise somewhere in between but still
called 1.1.20-2.6. Ah well.

Roger
