Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbUDXEdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbUDXEdL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 00:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUDXEdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 00:33:11 -0400
Received: from mail.tpgi.com.au ([203.12.160.59]:20918 "EHLO mail3.tpgi.com.au")
	by vger.kernel.org with ESMTP id S261918AbUDXEdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 00:33:09 -0400
Date: Sat, 24 Apr 2004 14:13:39 +1000
From: "Nigel Cunningham" <ncunningham@linuxmail.com>
To: "Grzegorz Piotr Jaskiewicz" <gj@pointblue.com.pl>
Subject: Re: swsusp: fix error handling in "not enough swap space"
Cc: "Pavel Machek" <pavel@ucw.cz>,
       "kernel list" <linux-kernel@vger.kernel.org>
Reply-To: ncunningham@linuxmail.com
References: <4089DC36.5020806@pointblue.com.pl> <opr6xykbzqruvnp2@laptop-linux.wpcb.org.au> <4089E761.5050708@pointblue.com.pl>
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <opr6x0o10uruvnp2@laptop-linux.wpcb.org.au>
In-Reply-To: <4089E761.5050708@pointblue.com.pl>
User-Agent: Opera M2/7.50 (Linux, build 663)
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm.

I agree with you; it does sound like the process of eating memory is  
grabbing all the swap. I can't see how it could be doing that, however. If  
you really want to use Pavel's version, I'd suggest adding some more debug  
statements. Perhaps print out the number of swap pages free at the start  
of that loop.

Regards,

Nigel


-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614, Australia.
+61 (2) 6251 7727 (wk)
