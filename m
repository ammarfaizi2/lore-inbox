Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131288AbRCHHgF>; Thu, 8 Mar 2001 02:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131289AbRCHHfp>; Thu, 8 Mar 2001 02:35:45 -0500
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:33997 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131288AbRCHHfd>; Thu, 8 Mar 2001 02:35:33 -0500
Message-ID: <3AA736A8.19C2C488@redhat.com>
Date: Thu, 08 Mar 2001 02:37:12 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac14
In-Reply-To: <E14an7j-0001rZ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 2.4.2-ac14
> o       Updated i810_audio.c                            (Doug Ledford)

I wanted to let people know that there is a lot of new code in this particular
update that needs testing.  The nice thing is that quake3 should now play with
this sound driver so the testing can at least be a little bit of fun ;-) 
Basically, all the stuff that used to work still should, mmap audio should now
work, and you should not have to specify any ftsodell=1 options to the driver
any more and it shouldn't sound like Alvin and the Chipmunks when you don't. 
If anyone finds problems with this driver, please let me know.  I tested what
I could, but I'm sure there are things I possibly missed.  Oh, one more thing,
when playing mp3's via xmms and using the oss output module, the number of
interrupts the system has to service is down by about 100 per second or more,
so it should be slightly lighter on system CPU time as well.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
