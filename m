Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965140AbWHQP23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbWHQP23 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 11:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbWHQP23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 11:28:29 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:65102 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965140AbWHQP21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 11:28:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=chQDETxOxVpV30Ik+hkGbE/mMKeB2qkie0zTUtuIaliE8NhlSk3HSqhCpp/qFYLME+KVrmk+U7fRgECxXaan+FWfEgoUazH33If2Ux+ozlvWvviscjrS+rWw4JlhO1clyomEBxTGYhehRYMqpeUobhLjilD2Fx1fbcozuCgO2cY=
Message-ID: <d120d5000608170828l75aeb693vb38f52ce71facf45@mail.gmail.com>
Date: Thu, 17 Aug 2006 11:28:25 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Luke Sharkey" <lukesharkey@hotmail.co.uk>
Subject: Re: Touchpad problems with latest kernels
Cc: andi@rhlx01.fht-esslingen.de, davej@redhat.com, gene.heskett@verizon.net,
       ian.stirling@mauve.plus.com, linux-kernel@vger.kernel.org,
       malattia@linux.it, lista1@comhem.se
In-Reply-To: <BAY114-F39F04F7AD7901A482EB648FA4D0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608161042.58005.dtor@insightbb.com>
	 <BAY114-F39F04F7AD7901A482EB648FA4D0@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/06, Luke Sharkey <lukesharkey@hotmail.co.uk> wrote:
>
> > >   Seeing as Linux is less easily controlled with the keyboard compared
> >to
> > > MS-Windows,
> >
> >Careful, you are threading dangerous waters here ;)
>
> Well, I wasn't trying to be inflammatory.  It's just that Microsoft seems to
> make such a big deal of how their OS can be controlled solely from keyboard.
>

I guess there is a difference as to what you call controlling. You
probably mean that in Windows is is easier to navigate GUI with
keyboard whereas I mean that in Linux or Unix you just start a
terminal program and do all necessary setup from within it (with
keyboard ;) )

> >Alt-F1 does it though
>
> Thanks for that.
>
> >Oh, another one... try booting with "ec_intr=0" on the kernel command line
> >to disable embedded controller interrupt mode.
>
> I tried this.  Was this meant to cause a major improvement in mouse control?
>  If there *was* a difference, it was only subtle.  I'd have to boot in to
> the kernel with and without this option a few times to see whether it truly
> makes a difference or not.
>

Well, it was just a thing to try. On some boxes interrupt mode of EC
was reported to hurt mice, while on others there was no effect or even
was an improvement.

> >And finally, can I mples get a dmesg (or /var/log/messages) of boot with
> >"i8042.debug=1 log_buf_len=131072" please?
>
> Yes.  Here is the output of dmesg with "i8042.debug=1 log_buf_len=131072"
> appended to the kernel line:
>

Hmm, don't see anything bad happening here.. Could you please send me
your /var/log/messages (still after booting with i8042.debug=1
log_buf_len=131072)? You should probably spare other people's
mailboxes and send it to me directly... Or put it on FTP somewhere.

Thanks!

-- 
Dmitry
