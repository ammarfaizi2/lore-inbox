Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131020AbRCPT3f>; Fri, 16 Mar 2001 14:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130517AbRCPT30>; Fri, 16 Mar 2001 14:29:26 -0500
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:47161 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S130216AbRCPT3M>; Fri, 16 Mar 2001 14:29:12 -0500
Message-ID: <3AB26A9A.9F1B3FAE@redhat.com>
Date: Fri, 16 Mar 2001 14:33:46 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ishikawa <ishikawa@yk.rim.or.jp>
CC: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: scsi_scan problem.
In-Reply-To: <3AB028BE.E8940EE6@redhat.com> <20010314213543.A30816@devserv.devel.redhat.com> <3AB030F6.246C6F23@redhat.com> <3AB24511.EA8BD2A2@yk.rim.or.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ishikawa wrote:
> 
> Hi,
> 
> I have an "old" Nakamichi CD changer.
> ("old" might be important consideration here. )
> 
> Should I test the patch submitted and report what I found ?
> (Or maybe I don't have to bother at this stage at all
> and  simply wait for the 2.5 development and debugging cycle?)

It would still be helpful because this problem has to be fixed before 2.5. 
The only question is whether to fix it with a simple patch such as I just
submitted, or a more complex patch that uses REPORT LUNs.  Part of that answer
is how my simple patch works on your device.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
