Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285423AbRLNRRH>; Fri, 14 Dec 2001 12:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285424AbRLNRQ6>; Fri, 14 Dec 2001 12:16:58 -0500
Received: from t2.redhat.com ([199.183.24.243]:10996 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S285423AbRLNRQp>; Fri, 14 Dec 2001 12:16:45 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <0ea901c184c2$896fc550$5601010a@prefect> 
In-Reply-To: <0ea901c184c2$896fc550$5601010a@prefect>  <0e8901c184c1$248476a0$5601010a@prefect> <0ddd01c184b3$ce15c470$5601010a@prefect> <066801c183f2$53f90ec0$5601010a@prefect> <20011213160007.D998D23CCB@persephone.dmz.logatique.fr> <25867.1008323156@redhat.com> <13988.1008348675@redhat.com> <15374.1008349429@redhat.com> 
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: "Thomas Capricelli" <orzel@kde.org>, linux-kernel@vger.kernel.org
Subject: Re: Mounting a in-ROM filesystem efficiently 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 14 Dec 2001 17:16:37 +0000
Message-ID: <16533.1008350197@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


brad@ltc.com said:
>  They do.  On that system just the low-level flash write code was kept
> in RAM, but the rest of the kernel was XIP from flash. 

Oh, right - so you run from RAM and disable interrupts while you're writing 
or erasing? That can work, but isn't an approach I really want to encourage :)



--
dwmw2


