Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161069AbWGJNHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069AbWGJNHd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161090AbWGJNHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:07:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:26218 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161069AbWGJNHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:07:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pkVyhlyQ46uN08f5TGI2+epelgPQ+S3V4PJP04NLB4Qf58/Gvqfbrt3U4aEgZwki3CYZgR+XCKgAVZXWme3ZjhUsMECh1db941/kTP/sL2dgYtfT3ul/vmbvm3lDcGc9lTEPhGL0axoRNmHUMaggn2LPTRRCi+c6EifC73WANrw=
Message-ID: <d120d5000607100607i47980d08w60a85be9aeca348@mail.gmail.com>
Date: Mon, 10 Jul 2006 09:07:30 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: [RFC][PATCH 9/9] -Wshadow: fixes for drivers/char/keyboard.c
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200607101313.42962.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607101313.42962.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> -static void kbd_keycode(unsigned int keycode, int down,
> +static void kbd_keycode(unsigned int keycode, int _down,
>                        int hw_raw, struct pt_regs *regs)
>  {

I dont like the "_down" name, feels artificial. If you don't mind I'll
change it to "key_down" before applying.

-- 
Dmitry
