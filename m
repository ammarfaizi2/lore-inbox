Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWAEOhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWAEOhP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWAEOhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:37:14 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:36426 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751364AbWAEOhL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:37:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HiZ8wgiPv/HibAEcaL0LaDHBwiekNROrdsrPzdSTPvCb6znYfI+xQ8fIMm+5TKjV0TCdsEujXpPaT/1cuCOCWXvVPtvoiOSaYGSpYtJP7A4bPUcy5yadSbLM9/XIzrnZ7T1+lMgdeHoqfWx3hv5a7qyci7pkfCGVk83H+QxwOUo=
Message-ID: <d120d5000601050637q7ec5688fi572aa4d27762d4cf@mail.gmail.com>
Date: Thu, 5 Jan 2006 09:37:10 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de>
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1EuVds-0000n9-00@mars.bretschneidernet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1EuVds-0000n9-00@mars.bretschneidernet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/06, Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de> wrote:
> Hi kernel-devs,
>
> [1.]
> a keyboard that is connected to to PS/2 port does not work with
> kernel 2.6.15. That is to say that no action is seen at the login
> promt if I enter any key.
>

Could you please boot with "i8042.debug", then reboot and send me
/var/log/messages or whatever file your syslog dumps kernel messages?

Thanks!

--
Dmitry
