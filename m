Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTJ2IUo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 03:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbTJ2IUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 03:20:44 -0500
Received: from smtp02.web.de ([217.72.192.151]:9764 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261916AbTJ2IUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 03:20:43 -0500
From: Mathias =?utf-8?q?Fr=C3=B6hlich?= <Mathias.Froehlich@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [pm] fix time after suspend-to-*
Date: Wed, 29 Oct 2003 09:20:37 +0100
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200310290920.37446.Mathias.Froehlich@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Userspace behavior on suspend transitions is still a bit fuzzy at best. I
> > am beginning to look at userspace requirements, so if anyone wants to send
> > me suggestions, no matter how trivial or wacky, please feel free (on- or
> > off-list).
> 
> Many userspace applications are not prepared for suspension, like
> Evolution. When suspending the machine for a long time, all IMAP
> sessions are broken as their counterpart TCP sockets timeout. While
> resuming, Evolution is unable to handle this condition and simply
> informs the network connection has been dropped.
>
> What about sending the SIGPWR signal to all userspace processes before
> suspending so applications like Evolution can be improved to handle this
> signal, drop their IMAP connections and then, when resuming, reestablish
> them?

I think that messagebus is for such stuff. ?!

   Greetings

      Mathias

-- 
Mathias Fröhlich, email: Mathias.Froehlich@web.de

