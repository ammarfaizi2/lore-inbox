Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264061AbUD0NCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbUD0NCg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 09:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbUD0NCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 09:02:36 -0400
Received: from [195.23.16.24] ([195.23.16.24]:61344 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S264061AbUD0NCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 09:02:17 -0400
Message-ID: <408E5944.8090807@grupopie.com>
Date: Tue, 27 Apr 2004 13:59:48 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <408DC0E0.7090500@gmx.net> <Pine.LNX.4.58.0404262116510.19703@ppc970.osdl.org> <1083045844.2150.105.camel@bach> <20040427092159.GC29503@lug-owl.de> <408E37D9.7030804@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.25.0.2; VDF: 6.25.0.34; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger wrote:

> 
> This way, the module format doesn't change, but we can do additional
> verification in the loader.
> 

I agree with Rusty Russell. Anything that we do can be circunvented.

If they are really into it, they can build a small tool to change the symbol 
information from the module.

The way I see it, they know a C string ends with a '\0'. This is like saying 
that a English sentence ends with a dot. If they wrote "GPL\0" they are 
effectively saying that the license *is* GPL period.

So, where the source code? :)

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"

