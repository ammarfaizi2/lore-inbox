Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264019AbTJFR4T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 13:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264020AbTJFR4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 13:56:19 -0400
Received: from pop.gmx.de ([213.165.64.20]:30604 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264019AbTJFR4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 13:56:17 -0400
X-Authenticated: #1033915
Message-ID: <3F81ACB5.2000309@GMX.li>
Date: Mon, 06 Oct 2003 19:56:05 +0200
From: Jan Schubert <Jan.Schubert@GMX.li>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031005
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Georg Nikodym <georgn@somanetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0_test6: CONFIG_I8K produces wrong/no keycodes for special
 buttons
References: <200310061034.h96AYGVP021010@dizzy.dz.net>	<3F814B37.5040009@GMX.li> <20031006134215.7b857e06.georgn@somanetworks.com>
In-Reply-To: <20031006134215.7b857e06.georgn@somanetworks.com>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Georg Nikodym wrote:

>For the keys that show nothing, if you look at /var/log/messages, I
>think you'll see something like:
>
>>lay - <nothing>
>>    
>>
>
>Oct  6 13:39:24 keller kernel: atkbd.c: Unknown key pressed (translated set 2, code 0x176, data 0x1, on isa0060/serio0).
>Oct  6 13:39:24 keller kernel: atkbd.c: Unknown key released (translated set 2, code 0x176, data 0x81, on isa0060/serio0).
>  
>
>>back - <nothing>
>>    
>>
>
>Oct  6 13:39:29 keller kernel: atkbd.c: Unknown key pressed (translated set 2, code 0x11e, data 0x3, on isa0060/serio0).
>Oct  6 13:39:29 keller kernel: atkbd.c: Unknown key released (translated set 2, code 0x11e, data 0x83, on isa0060/serio0).
>
Indeed, this is exactly what i get :-).

>-g (who's been too lazy to attempt the atkbd.c patchery needed to fix this)
>
So, i assume you will fix this?

Thx,
Jan


