Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264131AbTIIMNi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 08:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbTIIMNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 08:13:38 -0400
Received: from CPE-203-51-31-218.nsw.bigpond.net.au ([203.51.31.218]:32496
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S264131AbTIIMMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 08:12:22 -0400
Message-ID: <3F5DC39B.39F16803@eyal.emu.id.au>
Date: Tue, 09 Sep 2003 22:12:11 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.22-aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test5: CONFIG_PCMCIA_WL3501 build fails
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

allmodconfig, i386:

  CC [M]  drivers/net/wireless/wl3501_cs.o
drivers/net/wireless/wl3501_cs.c: In function `wl3501_mgmt_join':
drivers/net/wireless/wl3501_cs.c:641: unknown field `id' specified in
initialize
r
drivers/net/wireless/wl3501_cs.c:641: warning: missing braces around
initializer
drivers/net/wireless/wl3501_cs.c:641: warning: (near initialization for
`sig.ds_
pset.el')
drivers/net/wireless/wl3501_cs.c:642: unknown field `el' specified in
initialize
r
drivers/net/wireless/wl3501_cs.c:643: unknown field `chan' specified in
initiali
zer
drivers/net/wireless/wl3501_cs.c: In function `wl3501_mgmt_start':
drivers/net/wireless/wl3501_cs.c:658: unknown field `id' specified in
initialize
r
drivers/net/wireless/wl3501_cs.c:658: warning: missing braces around
initializer
drivers/net/wireless/wl3501_cs.c:658: warning: (near initialization for
`sig.ds_
pset.el')
drivers/net/wireless/wl3501_cs.c:659: unknown field `el' specified in
initialize
r
drivers/net/wireless/wl3501_cs.c:660: unknown field `chan' specified in
initiali
zer
drivers/net/wireless/wl3501_cs.c:663: unknown field `id' specified in
initialize
r
drivers/net/wireless/wl3501_cs.c:664: unknown field `el' specified in
initialize
r
drivers/net/wireless/wl3501_cs.c:665: unknown field `data_rate_labels'
specified
 in initializer
drivers/net/wireless/wl3501_cs.c:673: unknown field `id' specified in
initialize
r
drivers/net/wireless/wl3501_cs.c:674: unknown field `el' specified in
initialize
r
drivers/net/wireless/wl3501_cs.c:675: unknown field `data_rate_labels'
specified
 in initializer
drivers/net/wireless/wl3501_cs.c:683: unknown field `id' specified in
initialize
r
drivers/net/wireless/wl3501_cs.c:684: unknown field `el' specified in
initialize
r
drivers/net/wireless/wl3501_cs.c:685: unknown field `atim_window'
specified in i
nitializer
drivers/net/wireless/wl3501_cs.c: In function
`wl3501_mgmt_scan_confirm':
drivers/net/wireless/wl3501_cs.c:702: parse error before `)'
drivers/net/wireless/wl3501_cs.c:705: parse error before `)'
drivers/net/wireless/wl3501_cs.c:740: parse error before `)'
drivers/net/wireless/wl3501_cs.c: In function `wl3501_mgmt_auth':
drivers/net/wireless/wl3501_cs.c:899: parse error before `)'
drivers/net/wireless/wl3501_cs.c: In function `wl3501_mgmt_association':
drivers/net/wireless/wl3501_cs.c:913: parse error before `)'
drivers/net/wireless/wl3501_cs.c: In function
`wl3501_mgmt_join_confirm':
drivers/net/wireless/wl3501_cs.c:923: parse error before `)'
drivers/net/wireless/wl3501_cs.c: In function
`wl3501_md_confirm_interrupt':
drivers/net/wireless/wl3501_cs.c:982: parse error before `)'
drivers/net/wireless/wl3501_cs.c: In function
`wl3501_get_confirm_interrupt':
drivers/net/wireless/wl3501_cs.c:1038: parse error before `)'
drivers/net/wireless/wl3501_cs.c: In function
`wl3501_start_confirm_interrupt':
drivers/net/wireless/wl3501_cs.c:1050: parse error before `)'
drivers/net/wireless/wl3501_cs.c: In function
`wl3501_assoc_confirm_interrupt':
drivers/net/wireless/wl3501_cs.c:1062: parse error before `)'
drivers/net/wireless/wl3501_cs.c: In function
`wl3501_auth_confirm_interrupt':
drivers/net/wireless/wl3501_cs.c:1074: parse error before `)'
drivers/net/wireless/wl3501_cs.c: In function `wl3501_rx_interrupt':
drivers/net/wireless/wl3501_cs.c:1090: parse error before `)'
drivers/net/wireless/wl3501_cs.c: In function `wl3501_exit_module':
drivers/net/wireless/wl3501_cs.c:2350: parse error before `)'
make[3]: *** [drivers/net/wireless/wl3501_cs.o] Error 1
make[2]: *** [drivers/net/wireless] Error 2
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
