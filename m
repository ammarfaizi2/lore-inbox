Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316217AbSFZBul>; Tue, 25 Jun 2002 21:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316243AbSFZBuk>; Tue, 25 Jun 2002 21:50:40 -0400
Received: from rrcs-sw-24-153-135-82.biz.rr.com ([24.153.135.82]:4001 "HELO
	UberGeek") by vger.kernel.org with SMTP id <S316217AbSFZBuj>;
	Tue, 25 Jun 2002 21:50:39 -0400
Subject: Urgent, Please respond - Re: max_scsi_luns and 2.4.19-pre10.
From: Austin Gonyou <austin@digitalroadkill.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1025052385.19462.5.camel@UberGeek>
References: <1025052385.19462.5.camel@UberGeek>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 25 Jun 2002 20:50:35 -0500
Message-Id: <1025056235.19779.4.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm really really sorry for asking such a seemingly stupid question, but
I'm having a very severe issue here and I can't seem to figure out the
fix. 

If someone could exchange emails with me for a few mins I'd be very
grateful. I see that I have max_scsi_luns in my System.map, but I cannot
see luns > 8(0-7) with 2.4.19-pre10. The same driver set works with the
default RH installed kernel(2.4.9). So it leads me to believe that
putting max_scsi_luns=128 (or even 16) in grub.conf isn't being
effective. 

Please help.

On Tue, 2002-06-25 at 19:46, Austin Gonyou wrote:
> This originally was asking for help regarding QLA2200's, but I've since
> discovered it's a kernel param problem that I'm not sure how to solve.
> 
> Using a default RH kernel (from SGI XFS installer) and passing
> max_scsi_luns=128 in grub, and for scsi_mod, it seems to work. 
> 
> But when I compile my own kernels, none of that stuff is modular, it's
> all built in. I though that passing max_scsi_luns at boot time would
> make the scsi subsystem just work with > 8 luns, but so far that doesn't
> appear to be the case. 
> 
> 
> Can someone please tell me where I've gone wrong? I'm so deep into this,
> I can't tell which way is up. 
> 
> TIA
> -- 
> Austin Gonyou <austin@digitalroadkill.net>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Austin Gonyou <austin@digitalroadkill.net>
