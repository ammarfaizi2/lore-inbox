Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbUDERD3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 13:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbUDERD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 13:03:28 -0400
Received: from ce.fis.unam.mx ([132.248.33.1]:42112 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id S261815AbUDERDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 13:03:24 -0400
From: Max Valdez <maxvalde@fis.unam.mx>
Organization: CCF
To: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: kernel BUG at page_alloc.c:98 -- compiling with distcc
Date: Mon, 5 Apr 2004 12:03:09 -0500
User-Agent: KMail/1.6.51
Cc: Marco Fais <marco.fais@abbeynet.it>, linux-kernel@vger.kernel.org
References: <406D3E8F.20902@abbeynet.it> <6.0.0.22.2.20040402163334.02abe7d8@pop.localnet> <20040402150535.GA13340@localhost>
In-Reply-To: <20040402150535.GA13340@localhost>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404051203.09954.maxvalde@fis.unam.mx>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I Sent an email a couple os weeks ago about the same issue.

But it wasnt so documented and organized.

I can say that the card and hardware are inocents, maybe the driver, the 
"remote" machines that hang are using the latest fedore stable kernel.

I would need really good pointing to the procedure to debug the problem, I'm 
not expert in anything about kernel.

I think it's a problem in the network handling because it happens on different 
kernels, in different hardware. And it happens from a couple of months ago 
(we got a new faster network "arquitecture") and the problems seems to be 
triggered by fast transport of file over NTF, and distcc. I remember having a 
crash using scp too for some iso files.

If needed I can help track this problem, but I need some hints on the 
procedure

Max

-- 
Linux garaged 2.6.5-rc2-mm3 #1 Fri Mar 26 11:07:16 CST 2004 i686 Intel(R) 
Pentium(R) 4 CPU 2.80GHz GenuineIntel GNU/Linux
-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GS/S d- s: a-29 C++(+++) ULAHI+++ P+ L++>+++ E--- W++ N* o-- K- w++++ O- M-- 
V-- PS+ PE Y-- PGP++ t- 5- X+ R tv++ b+ DI+++ D- G++ e++ h+ r+ z**
------END GEEK CODE BLOCK------
gpg-key: http://garaged.homeip.net/gpg-key.txt
