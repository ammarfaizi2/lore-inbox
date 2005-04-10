Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVDJSoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVDJSoT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 14:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVDJSoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 14:44:19 -0400
Received: from mail1.kontent.de ([81.88.34.36]:61159 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261558AbVDJSoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 14:44:16 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] zero disk pages used by swsusp on resume
Date: Sun, 10 Apr 2005 20:45:22 +0200
User-Agent: KMail/1.7.1
Cc: Andreas Steinmetz <ast@domdv.de>, linux-kernel@vger.kernel.org
References: <1113145420344@pavel_ucw.cz> <4259432F.4040206@domdv.de> <20050410181846.GB1349@elf.ucw.cz>
In-Reply-To: <20050410181846.GB1349@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504102045.22323.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > Hi! What about doing it right? Encrypt it with symmetric cypher
> > > and store key in suspend header. That way key is removed automagically
> > > while fixing signatures. No need to clear anythink.

You might want to leave the key in the kernel image. You need to boot the
same image anyway. Leaving the key in the header will not increase
security while the os is down.

	Regards
		Oliver

