Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264964AbUD2Ujr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264964AbUD2Ujr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbUD2Ujp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:39:45 -0400
Received: from mail1.kontent.de ([81.88.34.36]:29130 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264964AbUD2UdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:33:21 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] USB: add new USB PhidgetServo driver
Date: Thu, 29 Apr 2004 22:33:14 +0200
User-Agent: KMail/1.5.1
Cc: Bryan Small <code_smith@comcast.net>, Sean Young <sean@mess.org>,
       Chester <fitchett@phidgets.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20040428181806.GA36322@atlantis.8hz.com> <200404292135.42713.oliver@neukum.org> <20040429194426.GA19315@kroah.com>
In-Reply-To: <20040429194426.GA19315@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404292233.14956.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Yes. You are describing a better devfs, but still devfs. Why not go
> > the whole way?
>
> {sigh}  Not again.  Come on Oliver...  Go read the archives for why
> Linus does not want us to put device nodes in sysfs.

Neither do I. Sorry for being unclear.

> Putting device attributes such as led colors, servo motor controls, etc,
> look to be much the same idea, are much different from the traditional
> block and character nodes we are used to in Unix.
>
> Think of them as mini device specific file systems instead, mounted in a
> device tree.

That I see as the problem. It's mission creep in sysfs. Reminds me of
procfs. IMHO, if you do io, use a device node.

	Regards
		Oliver

