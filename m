Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264890AbRFYRLL>; Mon, 25 Jun 2001 13:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264894AbRFYRLA>; Mon, 25 Jun 2001 13:11:00 -0400
Received: from mnh-1-19.mv.com ([207.22.10.51]:25350 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S264890AbRFYRKu>;
	Mon, 25 Jun 2001 13:10:50 -0400
Message-Id: <200106251825.NAA02909@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: "Bulent Abali" <abali@us.ibm.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Stevenson <mistral@stev.org>, riel@conectiva.com.br
Subject: Re: all processes waiting in TASK_UNINTERRUPTIBLE state 
In-Reply-To: Your message of "Mon, 25 Jun 2001 12:48:46 -0400."
             <OF831FC2D7.C211A862-ON85256A76.005AEC98@pok.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 25 Jun 2001 13:25:22 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

abali@us.ibm.com said:
> Can you give more details?  Was there an aic7xxx scsi driver on the
> box? run_task_queue(&tq_disk) should eventually unlock those pages but
> they remain locked.  I am trying to narrow it down to fs/buffer code
> or the SCSI driver aic7xxx in my case.

Rik would be the one to tell you whether there was an aic7xxx driver on the 
physical box.  There obviously isn't one on UML, so if we're looking at the 
same bug, it's in the generic code.

				Jeff


