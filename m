Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288616AbSADMRe>; Fri, 4 Jan 2002 07:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288611AbSADMQH>; Fri, 4 Jan 2002 07:16:07 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:10245 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S288607AbSADMP5>; Fri, 4 Jan 2002 07:15:57 -0500
Date: Fri, 4 Jan 2002 10:16:08 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [tested PATCH] 2.5.2-pre7 advansys SCSI adapter driver
Message-ID: <20020104101608.F26824@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Douglas Gilbert <dougg@torque.net>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
In-Reply-To: <3C3542AE.BAD31344@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C3542AE.BAD31344@torque.net>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 04, 2002 at 12:50:38AM -0500, Douglas Gilbert escreveu:

> Changes were added in lk 2.5.2-pre7 to the advansys SCSI adapter driver
> that let it compile. It would seem that the author didn't have any
> appropriate hardware to check the driver (since it dies almost
> immediately and takes the machine with it).
>
> This patch http://www.torque.net/sg/p/sg252p7.diff.gz
> will hopefully make the advansys driver useful again.
> It is not perfect but it:
>   - runs on a Athlon UP box
>   - runs on a dual Celeron SMP box
>   - is running the machine that sent this post
> I have been running variations of this patch for the last
> 3 weeks and it has been sent to Linus and the lkml before.
>
> Perhaps those helpful people who send speculative fixes to Linus could
> mark them clearly as "untested".

That was the case. I said that it didn't had the board. But I planned to
get one that Riel has on his test (iirc) machine to test the patch. Now you
have fixed it, thanks.

I'll take a look at your patch and see if with your changes the
scsi_assign_lock patch that probably will appear in pre8 is still needed
for the advansys driver.

- Arnaldo
