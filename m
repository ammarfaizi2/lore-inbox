Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbVAETE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbVAETE0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 14:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbVAETE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 14:04:26 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:4336 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262551AbVAETEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 14:04:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=MWfFAKO7CZPlWUxzMxJyQ3p7uh/yZizCzINNWbUCldYpqMYGdZg3nUfjGalYUweDlex35Ji6iIryqvYMzaZSZBJQ5KEeRSEsHw8/GZyi1TH6ZtJviDuSe8kFRu5ojilatJT5vSFcGLV8g9sCxZqMVT87VQqRWvLlO5jJWaLwcSI=
Message-ID: <d120d50005010510543532e0bf@mail.gmail.com>
Date: Wed, 5 Jan 2005 13:54:45 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Meelis Roos <mroos@linux.ee>
Subject: Re: 2.6.9+ keyboard LED problem
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOC.4.61.0501052035430.9146@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.SOC.4.61.0501051856090.9146@math.ut.ee>
	 <200501051328.37849.dtor_core@ameritech.net>
	 <Pine.SOC.4.61.0501052035430.9146@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2005 20:38:34 +0200 (EET), Meelis Roos <mroos@linux.ee> wrote:
> > Seems to work fine here. The led is blinking rapidly but I can type just
> > fine and touchpad works as well.
> >
> > What kind of box do you have? UP/SMP, Preempt?
> 
> UP, Celeron 900 on i815. Happens on 2 identical computers, one preempt,
> one not preempt. PS/2 keyboard and mouse on one, only PS/2 keyboard on
> the other (and USB mouse that is probably unimportant).
>

The big input update went in with 2.6.9-rc2-bk4.Could you try booting
-bk3 and -bk4 to verify that those changes are to blame?

-- 
Dmitry
