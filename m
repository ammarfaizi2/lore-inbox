Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbUEAVxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUEAVxT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 17:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUEAVxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 17:53:19 -0400
Received: from web02-imail.bloor.is.net.cable.rogers.com ([66.185.86.76]:30792
	"EHLO web02-imail.rogers.com") by vger.kernel.org with ESMTP
	id S261802AbUEAVxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 17:53:18 -0400
Date: Sat, 1 May 2004 17:53:19 -0400
From: Sean Estabrooks <seanlkml@rogers.com>
To: Marc Boucher <marc@linuxant.com>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, riel@redhat.com,
       tconnors+linuxkernel1083378452@astro.swin.edu.au, mbligh@aracnet.com,
       torvalds@osdl.org, nico@cam.org
Subject: Re: [PATCH] clarify message and give support contact for non-GPL
 modules
Message-Id: <20040501175319.6e34ebb5.seanlkml@rogers.com>
In-Reply-To: <3F6634E3-9BB9-11D8-B83D-000A95BCAC26@linuxant.com>
References: <772768DC-9BA3-11D8-B83D-000A95BCAC26@linuxant.com>
	<Pine.LNX.4.44.0405011529541.30657-100000@xanadu.home>
	<20040501205336.GA27607@valve.mbsi.ca>
	<20040501173450.006bae55.seanlkml@rogers.com>
	<3F6634E3-9BB9-11D8-B83D-000A95BCAC26@linuxant.com>
Organization: 
X-Mailer: Sylpheed version 0.9.9-gtk2-20040229 (GTK+ 2.2.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at web02-imail.rogers.com from [24.103.219.176] using ID <seanlkml@rogers.com> at Sat, 1 May 2004 17:52:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 May 2004 17:48:14 -0400
Marc Boucher <marc@linuxant.com> wrote:

> Sean,
> 
> I think that your wording is problematic, because:
> 
> - A module with non-GPL license could be distributed in source form.

That's not a problem.   Feel free to add other checks to suppress this
message for other licenses.

> - Its author can also be an individual or organization, not necessarily 
> a vendor.

Please suggest a better word than vendor so I can update the patch.

> - The word "tainted" is confusing and needlessly scary for average 
> users.

The FACT is the kernel is TAINTED.  It's important that the user
understand why so that when they see TAINTED message in OOPS 
they are not confused.

