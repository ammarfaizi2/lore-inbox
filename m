Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262785AbVAFJML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbVAFJML (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 04:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262786AbVAFJML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 04:12:11 -0500
Received: from CPE-139-168-157-43.nsw.bigpond.net.au ([139.168.157.43]:46329
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S262785AbVAFJMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 04:12:09 -0500
Message-ID: <41DD00DA.4070307@eyal.emu.id.au>
Date: Thu, 06 Jan 2005 20:11:54 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm2
References: <20050106002240.00ac4611.akpm@osdl.org>
In-Reply-To: <20050106002240.00ac4611.akpm@osdl.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Surprisingly, this is what I get for 'make distclean':

scripts/Makefile.clean:10: fs/umsdos/Makefile: No such file or directory
make[2]: *** No rule to make target `fs/umsdos/Makefile'.  Stop.
make[1]: *** [fs/umsdos] Error 2
make: *** [_clean_fs] Error 2

fs/umsdos is practically empty.

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	If attaching .zip rename to .dat
