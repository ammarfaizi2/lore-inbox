Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWDZJve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWDZJve (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 05:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWDZJve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 05:51:34 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:27235 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751409AbWDZJvd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 05:51:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uCQzQW8QAb5hi2jvi/j3s+rIaNnEuGHiORs1X042s0Yr8TiA6isE9+U4GY1C7XXqxr2yGs7OgJNZlVVrKF9oCO2KyHtUQ9tzBz7dwAnJ0+qQJNAqI8ydsVJQig1aWeiB4yrT4bI8OuZs6UtKiGW9DWhkvxmMwASef0TTMAvgGb0=
Message-ID: <9a8748490604260251n396ba160h50eec05eda528d63@mail.gmail.com>
Date: Wed, 26 Apr 2006 11:51:33 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Razvan Stoica" <mstoica@bitdefender.com>
Subject: Re: PROBLEM when restarting xdm
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <98045022.20060426122646@bitdefender.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <98045022.20060426122646@bitdefender.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/06, Razvan Stoica <mstoica@bitdefender.com> wrote:
> Hello,
> As directed by the helpful REPORTING-BUGS document, I am submitting to
> your attention this info, in the hope that it may be useful. I suspect
> I should be actually submitting this report to ATI, but perhaps you
[snip]
> EIP:    0060:[<c0113a16>]    Tainted: P      VLI
[snip]
>  [<e0aeff45>] _firegl_release_agp+0x15/0x140 [fglrx]
>  [<e0add525>] firegl_takedown+0x335/0xb80 [fglrx]
>  [<e0adc8cf>] firegl_release+0x12f/0x190 [fglrx]
>  [<e0ad51cb>] ip_firegl_release+0xd/0x10 [fglrx]
[snip]

Yes. Report it to ATI, it looks like their code is involved here.

If you can reproduce the problem with a non-tainted kernel (that is,
without the closed-source ATI module ever having been loaded), then
please re-submit the bugreport with crash info from the non-tainted
kernel. Then someone on LKML may be able to help you, otherwise only
ATI can help you.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
