Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285264AbRLFWxF>; Thu, 6 Dec 2001 17:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285254AbRLFWw6>; Thu, 6 Dec 2001 17:52:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17427 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285264AbRLFWwl>; Thu, 6 Dec 2001 17:52:41 -0500
Subject: Re: SMP/cc Cluster description
To: bcrl@redhat.com (Benjamin LaHaise)
Date: Thu, 6 Dec 2001 22:59:36 +0000 (GMT)
Cc: davem@redhat.com (David S. Miller), lm@bitmover.com,
        phillips@bonn-fries.net, davidel@xmailserver.org,
        rusty@rustcorp.com.au, Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
        lars.spam@nocrew.org, alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011206172708.B31752@redhat.com> from "Benjamin LaHaise" at Dec 06, 2001 05:27:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16C7UO-0003QE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Dec 06, 2001 at 01:02:02PM -0800, David S. Miller wrote:
> > We've done %90 of the "other stuff" already, why waste the work?
> > We've done the networking, we've done the scheduler, and the
> > networking/block drivers are there too.
> 
> The scheduler doesn't scale too well...

Understatement. However retrofitting a real scheduler doesn't break the
scalability of the system IMHO.
