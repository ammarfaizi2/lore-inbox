Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285273AbRLFWcE>; Thu, 6 Dec 2001 17:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285265AbRLFWbu>; Thu, 6 Dec 2001 17:31:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:52242 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285269AbRLFWbA>; Thu, 6 Dec 2001 17:31:00 -0500
Subject: Re: SMP/cc Cluster description
To: lm@bitmover.com (Larry McVoy)
Date: Thu, 6 Dec 2001 22:38:14 +0000 (GMT)
Cc: phillips@bonn-fries.net (Daniel Phillips), lm@bitmover.com (Larry McVoy),
        davem@redhat.com (David S. Miller), davidel@xmailserver.org,
        rusty@rustcorp.com.au, Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
        lars.spam@nocrew.org, alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011206121004.F27589@work.bitmover.com> from "Larry McVoy" at Dec 06, 2001 12:10:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16C79j-0003LO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the hardware's coherency.  No locks in the vfs or fs, that's all done
> in the mmap/page fault path for sure, but once the data is mapped you
> aren't dealing with the file system at all.

ftruncate
