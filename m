Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316182AbSFZEDd>; Wed, 26 Jun 2002 00:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316187AbSFZEDc>; Wed, 26 Jun 2002 00:03:32 -0400
Received: from rrcs-sw-24-153-135-82.biz.rr.com ([24.153.135.82]:12718 "HELO
	UberGeek") by vger.kernel.org with SMTP id <S316182AbSFZEDb>;
	Wed, 26 Jun 2002 00:03:31 -0400
Subject: Re: Urgent, Please respond - Re: max_scsi_luns and 2.4.19-pre10.
From: Austin Gonyou <austin@digitalroadkill.net>
To: jw schultz <jw@pegasys.ws>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020625204747.D26789@pegasys.ws>
References: <1025052385.19462.5.camel@UberGeek>
	 <1025056235.19779.4.camel@UberGeek> <20020625194806.C26789@pegasys.ws>
	 <1025060739.20340.6.camel@UberGeek>  <20020625204747.D26789@pegasys.ws>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 25 Jun 2002 23:03:28 -0500
Message-Id: <1025064208.20341.10.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-25 at 22:47, jw schultz wrote:
...
> I don't have -aa but that is -1.  I would suggest a bit of
> greping.
> 
> I seriously doubt changing it to 16 would cause data
> corruption.  It will either work or not.  If it doesn't you
> will crash on boot/init.
> 

yeah...I hear that. I tried some grepping, but didn't come up with much
since #define MAX_SCSI_LUNS 0xFFFFFFFF; replaced 8, and then it's seems
nothing like the mainline code, so it's much different. 

If Andrea is listening, can you tell us if that's correct or not? Also,
it seems that passing max_scsi_luns=128 or even 10 or something at boot
time does not get parsed by scsi_mod, if CONFIG_SCSI=y. 

Can someone shed some light on that?


> 
> -- 
> ________________________________________________________________
> 	J.W. Schultz            Pegasystems Technologies
> 	email address:		jw@pegasys.ws
> 
> 		Remember Cernan and Schmitt
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Austin Gonyou <austin@digitalroadkill.net>
