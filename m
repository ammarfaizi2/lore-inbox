Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273392AbRINOSu>; Fri, 14 Sep 2001 10:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273395AbRINOSl>; Fri, 14 Sep 2001 10:18:41 -0400
Received: from [208.187.172.194] ([208.187.172.194]:33544 "HELO
	odin.oce.srci.oce.int") by vger.kernel.org with SMTP
	id <S273394AbRINOS0>; Fri, 14 Sep 2001 10:18:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Joshua M. Schmidlkofer" <menion@srci.iwpsd.org>
To: Justin Guyett <justin@soze.net>
Subject: Re: Compining NetFilter: depmod, undefined symbols in 2.4.9
Date: Fri, 14 Sep 2001 08:16:48 -0600
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0109132216360.12327-100000@kobayashi.soze.net>
In-Reply-To: <Pine.LNX.4.33.0109132216360.12327-100000@kobayashi.soze.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010914141831Z273394-760+12692@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dont' forget 'make dep'

On Thursday 13 September 2001 11:17 pm, Justin Guyett wrote:
> On Thu, 13 Sep 2001, Colin Frank wrote:
> > There seems to be a mismatch with /System.map and /proc/ksyms
> > form the coorresponding kernel.
> > make bzlilo; make modules; make modules_install, and boot on the
> > /vmlinuz kernel.
>
> It means you either didn't do make clean, or make clean wasn't good enough
> and you needed to copy the .config away, make mrproper, and copy the
> config back.
>
>
> justin
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
