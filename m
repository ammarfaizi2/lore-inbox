Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269412AbRH0WQg>; Mon, 27 Aug 2001 18:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269428AbRH0WQ0>; Mon, 27 Aug 2001 18:16:26 -0400
Received: from mail.cdlsystems.com ([207.228.116.20]:2827 "EHLO cdlsystems.com")
	by vger.kernel.org with ESMTP id <S269412AbRH0WQV>;
	Mon, 27 Aug 2001 18:16:21 -0400
Message-ID: <001501c12f45$668d9c10$160e10ac@hades>
From: "Mark Cuss" <mcuss@cdlsystems.com>
To: <peterw@dascom.com.au>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <XFMail.20010828080242.peterw@dascom.com.au>
Subject: Re: Files missing from filesystem?  (2.4.9)
Date: Mon, 27 Aug 2001 16:12:46 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Return-Path: mcuss@cdlsystems.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: mcuss@cdlsystems.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The most likely cause (i.e. it's happened to me) is that bdflush had
stopped
> working.
> Thats the process responsible for making sure changes to files are
actually
> comitted to disk.
>
> Check the logs again and search for bdflush.

I looked through all the /var/log/messages files (actually all the files in
/var/log) and can't spot any bdflush entries.
This does however sound like it may be the suspect....  The machine has not
been down since these changes were made, so I figured that they would
"eventually" make their way to disk...  Perhaps I'm wrong.

Any other Ideas ?  :)

Thanks,
Mark



