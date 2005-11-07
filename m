Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965102AbVKGUkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbVKGUkr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965300AbVKGUkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:40:46 -0500
Received: from xproxy.gmail.com ([66.249.82.197]:865 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965102AbVKGUki convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:40:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M4wIkdjatnayYRuoSpSOi9PLBVdHyXGtzwb4DD8qFbu+0SV8B6+fFySNtwZGTe4VJfo6WiJ5j0TmGCclf/cDJxsdJBbHn/hbfmJQSd2lDWEWnac4V6G3HVNmuVsL+nuK5fl9EBpIsz16juuzzUhYOtCPrU4IWDhpy+Ak3U+D7Jw=
Message-ID: <d120d5000511071240v5b34d6fakf60bf1e9d8f84cd8@mail.gmail.com>
Date: Mon, 7 Nov 2005 15:40:37 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: 2.6.14-mm1
Cc: Andrew Morton <akpm@osdl.org>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org, Steven French <sfrench@us.ibm.com>,
       matthieu castet <castet.matthieu@free.fr>, Greg KH <greg@kroah.com>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <200511072021.jA7KL4kA030734@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051106182447.5f571a46.akpm@osdl.org>
	 <436F7DAA.8070803@ums.usu.ru> <20051107115210.33e4f0bf.akpm@osdl.org>
	 <200511072021.jA7KL4kA030734@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/05, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
>
> alt-sysrq still works - I can sysrq-T to get traces, -S to sync, -B to reboot
> and so on, and the output gets through klogd and syslogd and into /var/adm/messages.
>

If SysRq works that means that i8042, atkbd and input core are
functioning properly and data from the keyboard reaches
drivers/char/keyboard.c... This is getting out of the area I am
familiar with ;(.

--
Dmitry
