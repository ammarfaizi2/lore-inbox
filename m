Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131320AbRCPUKi>; Fri, 16 Mar 2001 15:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131315AbRCPUK3>; Fri, 16 Mar 2001 15:10:29 -0500
Received: from zmamail05.zma.compaq.com ([161.114.64.105]:13830 "HELO
	zmamail05.zma.compaq.com") by vger.kernel.org with SMTP
	id <S131313AbRCPUKU>; Fri, 16 Mar 2001 15:10:20 -0500
Message-ID: <3AB27335.FF82FFAB@zk3.dec.com>
Date: Fri, 16 Mar 2001 15:10:29 -0500
From: Peter Rival <frival@zk3.dec.com>
X-Mailer: Mozilla 4.6 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
Cc: Ishikawa <ishikawa@yk.rim.or.jp>, Pete Zaitcev <zaitcev@redhat.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: scsi_scan problem.
In-Reply-To: <3AB028BE.E8940EE6@redhat.com> <20010314213543.A30816@devserv.devel.redhat.com> <3AB030F6.246C6F23@redhat.com> <3AB24511.EA8BD2A2@yk.rim.or.jp> <3AB26A9A.9F1B3FAE@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug, could you check how this patch works if you have the qla2x00 installed in an
Alpha box?  I'm hoping this is part of the source of my problems, but I'm not
positive.  (I'd do it, but my system is running benchmarks for the next several
days.)  Thanks!

 - Pete

Doug Ledford wrote:

> Ishikawa wrote:
> >
> > Hi,
> >
> > I have an "old" Nakamichi CD changer.
> > ("old" might be important consideration here. )
> >
> > Should I test the patch submitted and report what I found ?
> > (Or maybe I don't have to bother at this stage at all
> > and  simply wait for the 2.5 development and debugging cycle?)
>
> It would still be helpful because this problem has to be fixed before 2.5.
> The only question is whether to fix it with a simple patch such as I just
> submitted, or a more complex patch that uses REPORT LUNs.  Part of that answer
> is how my simple patch works on your device.
>
> --
>
>  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
>       Please check my web site for aic7xxx updates/answers before
>                       e-mailing me about problems
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

