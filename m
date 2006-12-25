Return-Path: <linux-kernel-owner+w=401wt.eu-S1752661AbWLYSiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661AbWLYSiO (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 13:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752633AbWLYSiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 13:38:14 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:52003 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbWLYSiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 13:38:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=gbjQ3Su43sPVkPuk7UuOO98f2qMNkZmI+2yuHUZ/WuenLDS3ej8JZz6uIZNSAwKmXCOQGdnZT6Wbm/wVnq544T6pm2Tg91fK6bc4Qzu5M8FaGfLMat18sfPa+BYguhDagkrflq+slGYD+vhBPWOuvvIBH5K19PoooFGsD8qLVU0=
Message-ID: <45901AA7.8080103@gmail.com>
Date: Mon, 25 Dec 2006 19:38:08 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Sergei Organov <osv@javad.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: moxa serial driver testing
References: <45222E7E.3040904@gmail.com> <87wt7hw97c.fsf@javad.com>	<4522ABC3.2000604@gmail.com> <878xjx6xtf.fsf@javad.com>	<4522B5C2.3050004@gmail.com> <87mz8borl2.fsf@javad.com>	<45251211.7010604@gmail.com> <87zmcaokys.fsf@javad.com>	<45254F61.1080502@gmail.com> <87vemyo9ck.fsf@javad.com>	<4af2d03a0610061355p5940a538pdcbd2cda249161e8@mail.gmail.com>	<87vemtnbyg.fsf@javad.com> <452A1862.9030502@gmail.com>	<87r6urket6.fsf@javad.com> <552766292581216610@wsc.cz> <871wmom6sb.fsf@javad.com>
In-Reply-To: <871wmom6sb.fsf@javad.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergei Organov wrote:
> Jiri Slaby <jirislaby@gmail.com> writes:
> 
>> osv@javad.com wrote:
>>> Hi Jiri,
>>>
>>> I've figured out that both old and new mxser drivers have two similar
>>> problems:
>>>
>>> 1. When there are data coming to a port, sometimes opening of the port
>>>    entirely locks the box. This is quite reproducible. Any idea what's
>>>    wrong and how can I help to debug it?
>> Could you test the patch below, if something changes?
> 
> Something did change. Now it becomes rather difficult to get the box to
> hang, though not impossible. Another thing that changed is that now I
> can see [parts of] oopses on screen. I've got two pictures of the screen

Positive.

> with different oopses. If you need them, let me know and I'll send them
> to you in a separate mail not to pollute lkml with JPEGs.

These are those you've posted in another post?

> As for the problem with module unloading when port is open, your another
> patch does fix it indeed.

at least some good news, thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
