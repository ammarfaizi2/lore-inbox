Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263167AbVBDMtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbVBDMtb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 07:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbVBDMtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 07:49:31 -0500
Received: from [195.23.16.24] ([195.23.16.24]:23254 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S265756AbVBDMq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 07:46:56 -0500
Message-ID: <42036E6F.1080104@grupopie.com>
Date: Fri, 04 Feb 2005 12:45:35 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net,
       Pekka Enberg <penberg@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, penberg@cs.helsinki.fi
Subject: Re: [uml-devel] Re: [PATCH 2.6] 4/7 replace uml_strdup by kstrdup
References: <1107228511.41fef75f4a296@webmail.grupopie.com> <84144f02050201235257d0ec1c@mail.gmail.com> <4200BFA1.2060808@grupopie.com> <200502032051.18191.blaisorblade@yahoo.it>
In-Reply-To: <200502032051.18191.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade wrote:
>[...]
> For UML, you should probably add the prototype to a good header inside 
> arch/um/include (those headers are in the searchpath for every file under 
> arch/um) - probably the one which declared uml_strdup. Yes, we have had to 
> duplicate prototypes for many functions... for inlines, we've had to provide 
> in many case a non-inline version.

Thanks for the tip. I'll have to read the code more carefully to 
understand better where the userspace ends and the kernel begins, so 
that I don't do similar mistakes in the future.

I'll redo the patch and post it for review, probably during next week. I 
don't think there is much hurry, because, even if this gets accepted, it 
should go in only in 2.6.12-rc1-mm1 or something like that, so there is 
still time to review this more carefully.

Thanks for reviewing the patch,

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
