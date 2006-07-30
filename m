Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWG3Rna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWG3Rna (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 13:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWG3Rna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 13:43:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:55876 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932391AbWG3Rna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 13:43:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=orDq8SzI9FFkcJBoLBzUJotSOedKEb1iwoS2l+V9UzdqzC8QozvrtPdbQ93dO0uC5WGLVR4zJljR6rrnrvXZhb2x5yiPwcLzbKNv2GfAG0KrPsecGhvdKsjtsrvwIzde/Pdsed4RiWjBE1glJuUqEef78b4VCfNh/ECrZsUdVjY=
Message-ID: <9a8748490607301043r5ffc1a87u782a24a2695058be@mail.gmail.com>
Date: Sun, 30 Jul 2006 19:43:28 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Guillaume Chazarain" <guichaz@yahoo.fr>
Subject: Re: 2.6.18-rc3 does not like an old udev (071)
Cc: "Greg KH" <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <44CCEC96.3020607@yahoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44CCEC96.3020607@yahoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/06, Guillaume Chazarain <guichaz@yahoo.fr> wrote:
> Hi,
>
> When updating only the kernel to 2.6.18-rc3 on Ubuntu Dapper/x86,
> /dev/usblp0
> is no more created on boot. If I manually create it, it works fine.
>
> Vanilla udev from Dapper: version 079 (Documentation/Changes requires
> udev 071 ;-) ).
>

Hmm, udev 071 works fine here...
i must admit though that I don't have any USB printers, so what I have
here is probably not 100% comparable.
Just wanted to point out that udev 071 and 2.6.18-rc3 is not
universally broken :-)

juhl@dragon:~$ cat /etc/slackware-version
Slackware 10.2.0
juhl@dragon:~$ uname -a
Linux dragon 2.6.18-rc3 #1 SMP PREEMPT Sun Jul 30 13:31:49 CEST 2006
i686 athlon-4 i386 GNU/Linux
juhl@dragon:~$ udevinfo -V
udevinfo, version 071


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
