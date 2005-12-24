Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbVLXQTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbVLXQTv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 11:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbVLXQTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 11:19:51 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:33329 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751244AbVLXQTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 11:19:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qsntqsRG4y48q/UTz6tBdUaKT2RP0xhyUxbxepiBgoRmysaLCVAdGbKNJLa1zdQUXqQhqHRhQKEc0ejGFIncDM7KFDA0aCHzDgy8Vh3HD2RY0FnLhCRs5Or/2d3U21JIW/I4M2XewvaWctCN+1+FLSy1uVnM8e83izQ4aTKhLUM=
Message-ID: <43AD74B8.3040006@gmail.com>
Date: Sat, 24 Dec 2005 18:18:00 +0200
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Wagner <daw@cs.berkeley.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Question] LinuxThreads, setuid - Is there user mode hook?
References: <200512231927.jBNJR2uG019083@taverner.CS.Berkeley.EDU>
In-Reply-To: <200512231927.jBNJR2uG019083@taverner.CS.Berkeley.EDU>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wagner wrote:
> Sorry, I don't know how to tell.  Perhaps you can document your
> library as 'not to be used with setuid/setgid programs'?  It seems
> surprising that a library would create multiple threads without warning
> the programmer that such a thing could happen (behind their back).

Hello,

Not every standard plug-in interface provides this ability. 
So I must use threads behind their back... And I need to 
deal with this last edge condition of the setuid.

Best Regards,
Alon Bar-Lev.
