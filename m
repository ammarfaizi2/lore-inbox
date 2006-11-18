Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756319AbWKRNcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756319AbWKRNcN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 08:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756320AbWKRNcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 08:32:13 -0500
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27]:8462 "EHLO
	smtp-vbr7.xs4all.nl") by vger.kernel.org with ESMTP
	id S1756317AbWKRNcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 08:32:12 -0500
Date: Sat, 18 Nov 2006 14:32:05 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] emit logging when a process receives a fatal signal
Message-ID: <20061118133205.GE31268@vanheusden.com>
References: <200611181146.kAIBkW52028010@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611181146.kAIBkW52028010@harpo.it.uu.se>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Sun Nov 19 00:08:47 CET 2006
X-Message-Flag: www.vanheusden.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 4. If this is about detecting the loss of specific processes
>    (network services say), then the problem can be solved in
>    user-space by using a separate monitor process, or by
>    controlling the processes via ptrace.

No not only for specific processes. It helps you detect problems with
processes you dind't know they have bugs and flakey hardware (sig 11).


Folkert van Heusden

-- 
Ever wonder what is out there? Any alien races? Then please support
the seti@home project: setiathome.ssl.berkeley.edu
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
