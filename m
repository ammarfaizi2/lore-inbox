Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030310AbVJESUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbVJESUF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 14:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbVJESUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 14:20:05 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:14769 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030308AbVJESUD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 14:20:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mI5KW90htaIx44+dH9peOZKmunxvBxldjSZpiX38i7XswQF+Df0A0nfn1cwNnVPEV2dfCQKWCefJUsTXsMb3FfBSarrmPO1cRB9qzCMvDl0/nXWyEHKbiDwExfTPvYubbWtWorAJT5TiySb3A189FTbqTRXB0WtA2Suf6X4z7+0=
Message-ID: <3888a5cd0510051120q1b307b5bg157aa3581c94c479@mail.gmail.com>
Date: Wed, 5 Oct 2005 20:20:02 +0200
From: Jiri Slaby <lnx4us@gmail.com>
Reply-To: Jiri Slaby <lnx4us@gmail.com>
To: umesh chandak <chandak_pict@yahoo.com>
Subject: Re: Kernel Panic Error in 2.6.10 !!!!
Cc: Badari Pulavarty <pbadari@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051005174803.70134.qmail@web35905.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1128534181.4754.68.camel@dyn9047017102.beaverton.ibm.com>
	 <20051005174803.70134.qmail@web35905.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/05, umesh chandak <chandak_pict@yahoo.com> wrote:
> hi,
> thanks for reply .
>
> But as i am using  gbdb patches on my test machine .i
> don't need initrd ,i am sure about it .and I can enter
> in my other kernel options . So I have my ide
> configured ,is this correct ?
Do you have /dev/console and /dev/null in /dev (not udev's files, but
spec files on /dev/hda6), this is known problem on fcs.
read http://www.fi.muni.cz/~xslaby/unpr/kernel.html, it's all in
czech, i haven't translate it yet, sorry, but find mkdir /tmp/dev
