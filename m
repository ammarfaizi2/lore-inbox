Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272980AbRIUJtp>; Fri, 21 Sep 2001 05:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273137AbRIUJtg>; Fri, 21 Sep 2001 05:49:36 -0400
Received: from nobugconsulting.ro ([213.157.160.38]:11270 "EHLO
	nobugconsulting.ro") by vger.kernel.org with ESMTP
	id <S272980AbRIUJta>; Fri, 21 Sep 2001 05:49:30 -0400
Message-ID: <3BAB0D41.5732661B@nobugconsulting.ro>
Date: Fri, 21 Sep 2001 12:49:53 +0300
From: lonely wolf <wolfy@nobugconsulting.ro>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: probable hardware bug: clock timer configuration lost
In-Reply-To: <3BAA9008.9837EA52@nobugconsulting.ro> <E15kEkB-0006nQ-00@the-village.bc.nu> <20010920221610.A14451@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.2(snapshot 20010817) (mail)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:

> > Its harmless. When we detect this we restore the state of the chip
> > correctly. If anything I should kill the printk but I'd still like to
> > figure the precise errata issue out
>
> Odd, I just got this during booting of my ALi based boards (never had seen
> it before).  Are we certain the test is correct?

actually I get the message with RH's 7.1 stock kernel, with 2.4.7 (patched
with mosix 1.1.2) and with 2.4.9-ac12. it's always there, waiting for me. I
kind of think to remove the printk, just as Alan suggested, because they are
_very_ annoying. I have big hard disks, but I wouldn't like to have them
filled with logs containing mostly this message :)

--
      Manuel Wolfshant       linux registered user #131416
       network administrator    NoBug Consulting Romania
The degree of technical confidence is inversely proportional to the
level of management.



