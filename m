Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272281AbTG1Biw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272263AbTG1ABs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:01:48 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272929AbTG0XBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:01:33 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair J Strachan <alistair@devzero.co.uk>
To: Balram Adlakha <b_adlakha@softhome.net>
Subject: Re: 2.6.0-test2 OSS emu10k1
Date: Sun, 27 Jul 2003 20:14:09 +0100
User-Agent: KMail/1.5.9
References: <20030727190257.GA2840@localhost.localdomain>
In-Reply-To: <20030727190257.GA2840@localhost.localdomain>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200307272014.09560.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 July 2003 20:02, Balram Adlakha wrote:
> I cannot compile the emu10k1 module:
>
> sound/oss/emu10k1/hwaccess.c:182: redefinition of `emu10k1_writefn0_2'
> sound/oss/emu10k1/hwaccess.c:164: `emu10k1_writefn0_2' previously defined
> here make[3]: *** [sound/oss/emu10k1/hwaccess.o] Error 1
> make[2]: *** [sound/oss/emu10k1] Error 2
> make[1]: *** [sound/oss] Error 2
> make: *** [sound] Error 2

Try patching a fresh tree, or redownload the 2.6.0-test2 tarball. It compiles 
fine here.

Cheers,
Alistair Strachan.
