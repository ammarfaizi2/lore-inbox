Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277564AbRJ3TTZ>; Tue, 30 Oct 2001 14:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277559AbRJ3TTP>; Tue, 30 Oct 2001 14:19:15 -0500
Received: from freeside.toyota.com ([63.87.74.7]:51978 "EHLO toyota.com")
	by vger.kernel.org with ESMTP id <S277598AbRJ3TTG>;
	Tue, 30 Oct 2001 14:19:06 -0500
Message-ID: <3BDEFD46.4C64E88D@lexus.com>
Date: Tue, 30 Oct 2001 11:19:34 -0800
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Mike Fedyk <mfedyk@matchmail.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nasty suprise with uptime
In-Reply-To: <E15yUqo-0005pU-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > Say, if the uptime field were unsigned it could
> > reach 995 days uptime before wraparound -
>
> Only on a 33bit processor - and those are kind of rare

Yes (DOH) - I was fooled when I saw the
long data type - when I actually did the
arithmetic to make sure, I saw that was
a red herring.

cu

jjs


