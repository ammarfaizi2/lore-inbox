Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbULUQXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbULUQXg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 11:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbULUQXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 11:23:35 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:9127 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261470AbULUQXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 11:23:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:reply-to:from:to:cc:references:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole;
        b=ugv3NfE8TVai6aw6Abd+WTA3QAVKsGv1KHaYePOY1iroU5DsMKpMT6QOaOKkqX1Decdgv1bDXAIj44zZ/V36PDh/dbIBAWSIFOwF1YFjwIQVuegNqhBPtdayk195mdZQ6SZYz2TxbvZr5FeLZdgw6xOJRa+8c28tHj1HK4B3o1g=
Message-ID: <000901c4e778$e9ba29c0$fd3465cb@y3e5j4>
Reply-To: "srinivas naga vutukuri" <srinivas.vutukuri@gmail.com>
From: "srinivas naga vutukuri" <srinivas.vutukuri@gmail.com>
To: "selvakumar nagendran" <kernelselva@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
References: <20041221094302.14478.qmail@web60608.mail.yahoo.com>
Subject: Re: Printk output on console
Date: Tue, 21 Dec 2004 21:49:52 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Selva,

You can go through, one of the help link on the log msgs...
     http://www.hk8.org/old_web/linux/run/ch08_03.htm
I think, they(kernel printk's) are directing to the console only...
Or you can observe, initially while booting it up, after console initiation
happened, it starts buffering out all the printk's output to the console
only.

But i did't remember, the code flow, at a particular point, the X or
something
the shell will take over of it...But any emergency msgs, from the kernel,
will be
coming onto the Console only...

I think, for your error msg, you can better google it...Its not able to
recognise,
the boot partition may be...

Regards,
srinivas.



----- Original Message -----
From: "selvakumar nagendran" <kernelselva@yahoo.com>
To: "srinivas naga vutukuri" <srinivas.vutukuri@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, December 21, 2004 3:13 PM
Subject: Re: Printk output on console


> Hi srinivas,
>      My question is "We are having lot more printk
> statements in the kernel source files. While the
> kernel is in execution where the output of all these
> statements will go? and can we redirect the output of
> printk to our console?
>      Please help me. Also I have one more error after
> having compiled my new kernel 2.6.9. After booting it
> shows the following error
>
> "Kernel panic syncing unable to mount block(0,0) VFS
> specify root =LABEL correctly"
>   Do u know how to deal with it?
>
> Thanks,
> selva
> --- srinivas naga vutukuri
> <srinivas.vutukuri@gmail.com> wrote:
>
> > Hi Selva,
> >
> >  I understood the question as where all/what all
> > printks (with
> >  line nos and the file names)
> >  you are looking for is it. I think, in a normal
> > printf  using the
> >  macros __FILE__ and __LINE__ will give that...
> >
> >  ex:
> >  printk(KERN_ERR "%s: Driver Initialisation failed",
> > __FILE__);
> >  Is this helpful...
> >
> > Regards,
> > srinivas.
> > -
> > To unsubscribe from this list: send the line
> > "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>
>
>
> __________________________________
> Do you Yahoo!?
> Read only the mail you want - Yahoo! Mail SpamGuard.
> http://promotions.yahoo.com/new_mail

