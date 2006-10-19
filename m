Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161396AbWJSLCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161396AbWJSLCN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 07:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161413AbWJSLCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 07:02:13 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:4020 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1161396AbWJSLCL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 07:02:11 -0400
Message-ID: <45375B21.6030009@gmail.com>
Date: Thu, 19 Oct 2006 13:01:53 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: "Kilau, Scott" <Scott_Kilau@digi.com>
CC: Greg KH <greg@kroah.com>, Greg.Chandler@wellsfargo.com,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: kernel oops with extended serial stuff turned on...
References: <335DD0B75189FB428E5C32680089FB9F803FE8@mtk-sms-mail01.digi.com> <20061018230939.GA7713@kroah.com> <335DD0B75189FB428E5C32680089FB9FA473E9@mtk-sms-mail01.digi.com> <45373F2F.90906@gmail.com> <45374868.5050109@gmail.com> <335DD0B75189FB428E5C32680089FB9FA473ED@mtk-sms-mail01.digi.com>
In-Reply-To: <335DD0B75189FB428E5C32680089FB9FA473ED@mtk-sms-mail01.digi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.51.75
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kilau, Scott wrote:
> Hi Jiri,
>  
> Well, what I did in my drivers was the following:
>  
> 1) Went to TTY_DRIVER_DYNAMIC_DEV.
[...]
> 3) Added the "tty_register_device()" to my driver to register those "extended" names.

Yup, this is correct fix of the problem. Would you post a patch for this?

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
