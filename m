Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVDTVIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVDTVIa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 17:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVDTVIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 17:08:30 -0400
Received: from colo.khms.westfalen.de ([213.239.196.208]:34947 "EHLO
	colo.khms.westfalen.de") by vger.kernel.org with ESMTP
	id S261811AbVDTVIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 17:08:25 -0400
Date: 20 Apr 2005 22:29:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <9VF1rZLXw-B@khms.westfalen.de>
In-Reply-To: <d3dvps$347$1@terminus.zytor.com>
Subject: Re: more git updates..
X-Mailer: CrossPoint v3.12d.kh15 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410065307.GC13853@64m.dyndns.org> <d3dvps$347$1@terminus.zytor.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@zytor.com (H. Peter Anvin)  wrote on 11.04.05 in <d3dvps$347$1@terminus.zytor.com>:

> Followup to:  <20050410065307.GC13853@64m.dyndns.org>
> By author:    Christopher Li <lkml@chrisli.org>
> In newsgroup: linux.dev.kernel
> >
> > There is one problem though. How about the SHA1 hash collision?
> > Even the chance is very remote, you don't want to lose some data do due
> > to "software" error. I think it is OK that no handle that
> > case right now. On the other hand, it will be nice to detect that
> > and give out a big error message if it really happens.
> >
>
> If you're actually worried about it, it'd be better to just use a
> different hash, like one of the SHA-2's (probably a better choice
> anyway), instead of SHA-1.

How could that help? *Every* hash has hash collisions. It's an unavoidable  
result of using less bits than the original data has.

MfG Kai
