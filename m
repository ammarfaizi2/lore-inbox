Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263237AbUJ2K5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263237AbUJ2K5C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 06:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263236AbUJ2K5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 06:57:02 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:47770 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263239AbUJ2Kzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 06:55:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=BFdbQpc+iYsw8JI6007B05xIMoWHKJMqZC4QXIPa/PIQ3WrEKPUX74xaxETABnHJWdEsURCR1JixQNqtcIXeN3uU9RrrkvLo4V9S59I1wK/ibacrdZk4vS6FsbYKB8hVF6Q9knUgHwMdyHCD7i7z9hHf9kY0h9n4uDRn5cyOtdc=
Message-ID: <2a4f155d04102903551f558132@mail.gmail.com>
Date: Fri, 29 Oct 2004 13:55:33 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
Reply-To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: SSH and 2.6.9
Cc: Andrew Morton <akpm@osdl.org>, dan@fullmotions.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0410291234530.22050@jjulnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1098906712.2972.7.camel@hanzo.fullmotions.com>
	 <Pine.LNX.4.61.0410272247460.3284@dragon.hygekrogen.localhost>
	 <1098912301.4535.1.camel@hanzo.fullmotions.com>
	 <1098913797.3495.0.camel@hanzo.fullmotions.com>
	 <Pine.LNX.4.61.0410280034020.3284@dragon.hygekrogen.localhost>
	 <20041028022942.7ef1a8b8.akpm@osdl.org>
	 <Pine.LNX.4.61.0410291234530.22050@jjulnx.backbone.dif.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Slackware 10 is (was?) known to have a faulty udev.rules files
breaking /dev/tty with latest 2.6 kernels. I already reported this to
Patrick Volkerding but have no idea if its fixed because I am now a
Debian user *g*.

Regards,
/ismail


On Fri, 29 Oct 2004 12:36:19 +0200 (CEST), Jesper Juhl <juhl-lkml@dif.dk> wrote:
> On Thu, 28 Oct 2004, Andrew Morton wrote:
> 
> > Date: Thu, 28 Oct 2004 02:29:42 -0700
> > From: Andrew Morton <akpm@osdl.org>
> > To: Jesper Juhl <juhl-lkml@dif.dk>
> > Cc: dan@fullmotions.com, linux-kernel@vger.kernel.org
> > Subject: Re: SSH and 2.6.9
> >
> > Jesper Juhl <juhl-lkml@dif.dk> wrote:
> > >
> > > Now I guess we just need for someone to find out why LEGACY_PTYS breaks
> > >  ssh (and other apps?) with kernels >= 2.6.9,
> >
> > Works OK here, witht he latest of everything.  Please send the faulty
> > .config.
> >
> > If you could generate the `strace -f' output from good and bad
> > sessions and identify where things went wrong, that would help.
> >
> 
> I have no problem here, and I can't reproduce it by enabling LEGACY_PTYS
> either, so you'll have to get the .config and strace etc from Danny Brow.
> 
> --
> Jesper Juhl
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Time is what you make of it
