Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbWHDJcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbWHDJcA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 05:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbWHDJcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 05:32:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:45085 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030287AbWHDJb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 05:31:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DW68amt8C4E1rgVShy4d30OBQGqVF4LuOBGb20uJmtxjrSZV+jBZ+5luOjBfzxqoNCXxkTUOOEsa2rsaU06nOIvUWxsSoQ0GOAjVhy9nLdOQi43j4W4Ou9YXDrM168tYRho2p+Fb39EiAjWqqC9vrhZVoYvInFhS9NVlcphm/98=
Message-ID: <9a8748490608040231u4c696f57sf7cae1b708456aec@mail.gmail.com>
Date: Fri, 4 Aug 2006 11:31:58 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Patrick McHardy" <kaber@trash.net>
Subject: Re: [patch 00/23] -stable review
Cc: "Greg KH" <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       stable@kernel.org, "Justin Forbes" <jmforbes@linuxtx.org>,
       "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy Dunlap" <rdunlap@xenotime.net>,
       "Dave Jones" <davej@redhat.com>,
       "Chuck Wolber" <chuckw@quantumlinux.com>,
       "Chris Wedgwood" <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <44D3125F.2050008@trash.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060804053807.GA769@kroah.com>
	 <9a8748490608040204o58f7f594qe8c3316fcdf00ea4@mail.gmail.com>
	 <44D30F04.9060300@trash.net>
	 <9a8748490608040219q3c385440u3503bf6504f84d4a@mail.gmail.com>
	 <44D3125F.2050008@trash.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/06, Patrick McHardy <kaber@trash.net> wrote:
> Jesper Juhl wrote:
> > On 04/08/06, Patrick McHardy <kaber@trash.net> wrote:
> >
> >> Jesper Juhl wrote:
> >> > Any chance that the fixes in the (latest) e1000 driver version
> >> > 7.1.9-k4 will get backported?
> >> >
> >> > I get messages along the lines of "kernel: Virtual device XXX asks to
> >> > queue packet!" and the device then refuses to work.
> >> > The last kernel where I know for a fact that it worked OK is 2.6.11,
> >> > so that's what the server is currently running.
> >>
> >> That message should never be seen on a device with a queue. What device
> >> exactly is "XXX"?
> >>
> > eth0.20
>
> This problem is fixed by "[patch 10/23] VLAN state handling fix".
>
Ahh, ok, I didn't realize that. That's great news, then there's a
chance that 2.6.17.8 will work for me - I'll certainly test that and
report back. I can't test on that server until monday though, so I
won't be able to test it before 2.6.17.8 is out.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
