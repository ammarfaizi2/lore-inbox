Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265641AbUEZQF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265641AbUEZQF4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 12:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265642AbUEZQFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 12:05:55 -0400
Received: from tristate.vision.ee ([194.204.30.144]:1258 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S265641AbUEZQFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 12:05:54 -0400
Message-ID: <40B4C060.5030202@vision.ee>
Date: Wed, 26 May 2004 19:05:52 +0300
From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040509)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>, kernel@kolivas.org,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.x kernel sluggish behavior
References: <40B49BD6.7050202@vision.ee> <20040526140513.GB2764@holomorphy.com>
In-Reply-To: <20040526140513.GB2764@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>What kernel version is this? Could you try with 2.6.6-mm4 if it was
>less recent than that?
>  
>
Right now it happens with 2.6.5-mm5. It has happened with all 
2.6.x(-mmY) I've tried. But as it seems
after reading Con's reply - this is known problem. So I won't send any 
vmstat/schedstat outputs unless
explicitly requested.

Although I agree with Con, that acroread/gecko should be fixed (because 
in-kernel
solution for this problem doesn't exist/is hard to do) some measures 
should still be implemented kernel-side
to at least soften the effects (it's kind of DoS for servers having 
acroread plugin installed and there
might be other apps/ways to trigger this although not known today).

Lenar


