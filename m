Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144006AbRAHOWE>; Mon, 8 Jan 2001 09:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144007AbRAHOVy>; Mon, 8 Jan 2001 09:21:54 -0500
Received: from [209.58.33.70] ([209.58.33.70]:63761 "EHLO ns1.sdnpk.org")
	by vger.kernel.org with ESMTP id <S144006AbRAHOVp>;
	Mon, 8 Jan 2001 09:21:45 -0500
Message-ID: <3A59CBC6.E85AF3EA@khi.sdnpk.org>
Date: Mon, 08 Jan 2001 19:16:38 +0500
From: Ansari <mike@khi.sdnpk.org>
X-Mailer: Mozilla 4.61 [en] (Win95; I)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-irda@pasta.cs.UiT.No" <linux-irda@pasta.cs.UiT.No>
Subject: Re: Delay in authentication.
In-Reply-To: <3A59C316.8001E42A@khi.sdnpk.org> <200101081331.FAA18576@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"David S. Miller" wrote:

>    Date:        Mon, 08 Jan 2001 18:39:34 +0500
>    From: Ansari <mike@khi.sdnpk.org>
>
>    I just installed Redhat 6.0. When i run "su" command it takes much
>    time to apper passwd prompt.  Its also taking much time in
>    authentication after entering the password.
>
> This definitely seems like the classic "/etc/nsswitch.conf is told to
> look for YP servers and you are not using YP", so have a look and fix
> nsswitch.conf if this is in fact the problem.
>

No /etc/nsswitch.conf is not looking for YP server. I hav following entry
in my /etc/nsswitch.conf

#       nis or yp               Use NIS (NIS version 2), also called YP






-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
