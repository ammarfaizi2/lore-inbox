Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbWHWJnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWHWJnH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 05:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWHWJnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 05:43:07 -0400
Received: from mail.gmx.de ([213.165.64.20]:39068 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751501AbWHWJnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 05:43:04 -0400
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 23 Aug 2006 11:43:02 +0200
From: "Robert Szentmihalyi" <robert.szentmihalyi@gmx.de>
In-Reply-To: <Pine.LNX.4.61.0608231129550.5799@yvahk01.tjqt.qr>
Message-ID: <20060823094302.235230@gmx.net>
MIME-Version: 1.0
References: <20060823091652.235230@gmx.net>
 <Pine.LNX.4.61.0608231129550.5799@yvahk01.tjqt.qr>
Subject: Re: Group limit for NFS exported file systems
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
X-Authenticated: #26149461
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >Hi,
> >
> >is there a group limit for NFS exported file systems in recent kernels?
> >One if my users cannot access directories that belong to a group he
> actually _is_ a member of. That, however, is true only when accessing them over
> NFS. On the local file system, everything is fine. UIDs and GIDs are the
> same on client and server, so that cannot be the problem. Client and server
> run Gentoo Linux with kernel 2.6.16 on the server and 2.6.17 on the client.
> >Any ideas?
> 
> Is his fsuid/fsgid suddenly different?
> 

No. He just gets "access denied" for no obvious reason.
 
> 
> Jan Engelhardt
> -- 

 Robert
