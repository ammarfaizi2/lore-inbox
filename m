Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161371AbWJSJmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161371AbWJSJmJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 05:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161373AbWJSJmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 05:42:09 -0400
Received: from mx0.karneval.cz ([81.27.192.122]:12385 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S1161371AbWJSJmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 05:42:05 -0400
Message-ID: <45374868.5050109@gmail.com>
Date: Thu, 19 Oct 2006 11:42:00 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: "Kilau, Scott" <Scott_Kilau@digi.com>, Greg KH <greg@kroah.com>,
       Greg.Chandler@wellsfargo.com, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: kernel oops with extended serial stuff turned on...
References: <335DD0B75189FB428E5C32680089FB9F803FE8@mtk-sms-mail01.digi.com> <20061018230939.GA7713@kroah.com> <335DD0B75189FB428E5C32680089FB9FA473E9@mtk-sms-mail01.digi.com> <45373F2F.90906@gmail.com>
In-Reply-To: <45373F2F.90906@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> We have a few options:
> - rewrite them to use TTY_DRIVER_DYNAMIC_DEV (I'm going to do this in 
> isicom anyway)

(But this won't solve anything if somebody has both "conflicting" cards.)

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
