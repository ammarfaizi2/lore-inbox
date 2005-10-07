Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030498AbVJGQeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030498AbVJGQeR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 12:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030499AbVJGQeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 12:34:17 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:13085 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030498AbVJGQeQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 12:34:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WkX9En3E2vYM2E9cWNC8SqqAqeNhEBByDHESup9aLWVCNALg2ZGX1OCGbnJBszuS3pvSdXtNkYz/SiwX/sSN17YB8c8stPm/3/cP0+BeGU6lmlPErX5GPm65Y7b2eWsC9bPWW/Mk1TpeyTe8V4Mv2bPQm+zyIDDZG5nAH6Fcj4I=
Message-ID: <3888a5cd0510070934x39288f31m368c58e1dd59d699@mail.gmail.com>
Date: Fri, 7 Oct 2005 18:34:15 +0200
From: Jiri Slaby <lnx4us@gmail.com>
Reply-To: Jiri Slaby <lnx4us@gmail.com>
To: David Vrabel <dvrabel@cantab.net>
Subject: Re: [patch] yenta: fix YENTA && !CARDBUS build
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <43467B7A.2000903@cantab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43414BFB.3090206@arcom.com> <43467B7A.2000903@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/05, David Vrabel <dvrabel@cantab.net> wrote:
> (Previous patch left a warning.)
>
> yenta_socket no longer builds if CONFIG_CARDBUS is disabled.  It doesn't
> look like ene_tune_bridge is relevant in the !CARDBUS configuration so
> I've just disabled it.
>
>
> yenta: fix build if YENTA && !CARDBUS
>
> (struct pcmcia_socket).tune_bridge only exists if CONFIG_CARDBUS is set but
> building yenta_socket without CardBus is valid.
>
This is a multi-part message in MIME format.

Are you really sure, that you have read Documentation/SubmittingPatches and
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
Nobody wants MIMEs. Include it as plain text

thanks,
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
