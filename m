Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVHGARf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVHGARf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 20:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVHGARf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 20:17:35 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:21893 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261368AbVHGARe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 20:17:34 -0400
Message-ID: <42F5531F.5040704@gmail.com>
Date: Sun, 07 Aug 2005 02:17:35 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Domen Puncer <domen@coderock.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc4-mm1] drivers/char/isicom.c old api rewritten
References: <42EE9C0F.30004@gmail.com> <20050806191233.GA7322@homer.coderock.org>
In-Reply-To: <20050806191233.GA7322@homer.coderock.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Domen Puncer napsal(a):

>You have much bigger chances of someone reviewing the patch if you
>at least split code changes and whitespace/type cleanups. 65k is a lot.
>  
>
Ok, 3 patches:
http://www.fi.muni.cz/~xslaby/lnx/isi_main.txt
this changes many lines of code, adds hotplug, firmware loading, add one 
fixme, because i have really no idea, what device feed to 
request_firmware when isa card is used

http://www.fi.muni.cz/~xslaby/lnx/isi_us.txt
unsigned short changed to u16 and similar, where it expect sized operands

http://www.fi.muni.cz/~xslaby/lnx/isi_w.txt
changes trying to convert code into CodingStyle
removed trailing spaces, some lines longer than 80 split

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

