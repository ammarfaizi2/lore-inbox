Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161058AbWJZWbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161058AbWJZWbk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 18:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161448AbWJZWbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 18:31:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:50892 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161058AbWJZWbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 18:31:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BH5M5jxd4l/SMxT+X+dglKDXaJ8xk9Lv0ZWA+EfswHlvJS7XxmNOi3oOsK34hP1SHTWTxGcxZWyu2NkHKzfjotC8sVZlI7DMBmmD+plTavMpwKnqYadJD0ilqY+cmE4drmHpa/yxWT58X5GJWofpyUbEaUQ4P4sxqop0ig15e6g=
Message-ID: <9a8748490610261531s539b0861t621e95c785b53d7@mail.gmail.com>
Date: Fri, 27 Oct 2006 00:31:37 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: removing drivers and ISA support? [Was: Char: correct pci_get_device changes]
Cc: "Jiri Slaby" <jirislaby@gmail.com>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20061026222525.GP27968@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4540F79C.7070705@gmail.com> <20061026222525.GP27968@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/06, Adrian Bunk <bunk@stusta.de> wrote:
> On Thu, Oct 26, 2006 at 07:59:56PM +0200, Jiri Slaby wrote:
> >...
> > And what about (E)ISA support. When converting to pci probing, should be ISA bus
> > support preserved (how much is ISA used in present)? -- it makes code ugly and long.
>
> There seem to be still many running 486 machines - and only the last 486
> boards also had PCI slots.
>
> While deprecating OSS drivers, I got emails from people still using some
> of the ISA cards.
>
> And there are even Pentium 4 boards with ISA slots available.
>
Not to mention many embedded boards - many pc104 boards use ISA, just
to mention one type.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
