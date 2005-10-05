Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbVJETrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbVJETrt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 15:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbVJETrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 15:47:48 -0400
Received: from qproxy.gmail.com ([72.14.204.196]:1907 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030349AbVJETrs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 15:47:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MGup0CjrVoKNSpTWcAr/xiKUxIHScZD3QvOrnkUdrnp/L8nVCLWxcoAxmYS8RQu7Tc9rqotBzOXRTWcMRY9k8MzBtd+mA5tbH0TSk4ytUz4jfzy8aMpmxckIozGxAPQGRuOl2h42ioG21XhJatoFoGJUxVwVIzmti/R8A8cnnbY=
Message-ID: <9a8748490510051247m477b1693i3fcb65271e500e23@mail.gmail.com>
Date: Wed, 5 Oct 2005 21:47:47 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: umesh chandak <chandak_pict@yahoo.com>
Subject: Re: Waring in kernel 2.6.10
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051005192754.11115.qmail@web35905.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051005192754.11115.qmail@web35905.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/05, umesh chandak <chandak_pict@yahoo.com> wrote:
> hi,
>            I have compiled a kernel 2.6.10 on FC3 it
> gives me the warning like this
>
>
>
> Warning: unable to open an initial console.
>

Did you remember to enable the proper console related options in your
kernel; like CONFIG_VGA_CONSOLE, CONFIG_FRAMEBUFFER_CONSOLE etc.
I guess it could also be problem with an old or incorrectly configured
udev so it can't find /dev/console or it could be a problem with your
initrd.

And if you could be bothered to stick "Warning: unable to open an
initial console." in google you'll see that you are not the first to
have a problem like that and there is *lots* of help available out
there.
Do a little research please (and if you've already done some research,
then letting people know what you've already checked when posting your
question is usually a good idea).

May I recommend this document :
http://www.catb.org/~esr/faqs/smart-questions.html

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
