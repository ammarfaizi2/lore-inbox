Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbVLLKzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbVLLKzI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 05:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVLLKzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 05:55:07 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:41299 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751225AbVLLKzG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 05:55:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f9gpQDmsAxw2wV5rGw0QGUkAdwIDYO1NXC8i7D3cQm1jt13KFK+K90TP8j08bSd5eweLYrcztsm6ddzUFO6IL+2ib2BQqb/RSeMPnGDv8qYCnJ8WXShzvahElJZpWAOEzMaQVR9yj/+eH+yzRk7PyF0r7HindPM2mYYyAf0joVE=
Message-ID: <21d7e9970512120255t4852129bx8f50c02efc59836c@mail.gmail.com>
Date: Mon, 12 Dec 2005 21:55:05 +1100
From: Dave Airlie <airlied@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Cc: Dave Hansen <haveblue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "SERGE E. HALLYN [imap]" <serue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hubertus Franke <frankeh@watson.ibm.com>, Paul Jackson <pj@sgi.com>
In-Reply-To: <1133994002.2869.73.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051114212341.724084000@sergelap>
	 <m1slt5c6d8.fsf@ebiederm.dsl.xmission.com>
	 <1133977623.24344.31.camel@localhost>
	 <1133978128.2869.51.camel@laptopd505.fenrus.org>
	 <1133978996.24344.42.camel@localhost>
	 <1133982048.2869.60.camel@laptopd505.fenrus.org>
	 <1133993636.30387.41.camel@localhost>
	 <1133994002.2869.73.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> again the DRM layer needs an audit, I'm not entirely sure if it doesn't
> get pids from userspace. THe rest of the kernel mostly ought to cope
> just fine.
>

Yes yet again, if you can think of it, the drm will have found a way
to do it :-)

the drmGetClient ioctl passes pids across the user/kernel boundary,
its the only place I can see in a quick look at the interfaces.... but
it isn't used for anything as far as I can see except for the dristat
testing utility..

Dave.
