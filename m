Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965354AbWJ2Tw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965354AbWJ2Tw1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 14:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965328AbWJ2Tw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 14:52:27 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:63522 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965354AbWJ2Tw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 14:52:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LV6BkffQ3yjQh5BsmXo1pwzsGdiBDOAfMFaG89FYCrsPw0R/iqt4QBD9L2y25UD526mbqTx0MiFi0wjoK6cFXhG36HkTC/wYf3WE7JqRM2SVMUfZb8+pIB2Ow870sudsRiJz4UoNn7y3FVLrAbUdEm5fY7rKvsXapUJvaakOz0M=
Message-ID: <5a4c581d0610291152r7f538188m4ce52fba1f5f4683@mail.gmail.com>
Date: Sun, 29 Oct 2006 20:52:26 +0100
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: loading EHCI_HCD slows down IDE disk performance by 50%
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <1162146560.14733.65.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5a4c581d0610291013w40c1b0e6g408051a79534956a@mail.gmail.com>
	 <1162146560.14733.65.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Sun, 2006-10-29 at 19:13 +0100, Alessandro Suardi wrote:
> > Any hints/tips about what to try with this issue will be
> >  of course very welcome.
>
> git bisect

As I clarified to Lee in private email, this method doesn't
 seem to apply in this situation, as the problem appeared
 when I selected CONFIG_EHCI_HCD in my build due to the
 purchase of the USB2.0 disk, back in the 2.6.16-rc cycle;
 so if the combination of high performance IDE + EHCI_HCD
 ever existed, it must be earlier than 2.6.16-rc5-git8.

Lacking any input I'll try to find out more in the next week
 by starting out at 2.6.10 and eventually earlier.

Thanks, ciao,

--alessandro

"...when I get it, I _get_ it"

     (Lara Eidemiller)
