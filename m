Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbTKSVXg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 16:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264137AbTKSVXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 16:23:36 -0500
Received: from mid-1.inet.it ([213.92.5.18]:7099 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S263942AbTKSVXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 16:23:35 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: test9 and bluetooth - got it :)
Date: Wed, 19 Nov 2003 22:19:02 +0100
User-Agent: KMail/1.5.4
References: <200311021853.47300.cova@ferrara.linux.it> <200311190052.45803.cova@ferrara.linux.it> <1069239043.4883.125.camel@pegasus>
In-Reply-To: <1069239043.4883.125.camel@pegasus>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200311192219.02964.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 11:50, mercoledì 19 novembre 2003, Marcel Holtmann ha scritto:

> >
> > Hope this can shed some light; I can made any test needed to narrow down
> > this issue, just let me know.
>
> another thing to try is to disable the SCO support of the HCI USB driver
> and in this case it don't uses ISOC transfers.

Tried it, and it worked. I've plugged and unplugged the usb dongle several 
times in a row without any crash.
It seems that you have got the issue.

I'll keep SCO support disabled for now; I can test whatever you want if you 
need me to.

Tnx!

-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

