Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319253AbSHUXsA>; Wed, 21 Aug 2002 19:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319255AbSHUXsA>; Wed, 21 Aug 2002 19:48:00 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:41457 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319253AbSHUXr6>; Wed, 21 Aug 2002 19:47:58 -0400
Subject: Re: Linux 2.4.20-pre2-ac6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: andersen@codepoet.org
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020821234411.GA26772@codepoet.org>
References: <200208212025.g7LKPda15450@devserv.devel.redhat.com> 
	<20020821234411.GA26772@codepoet.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Aug 2002 00:53:14 +0100
Message-Id: <1029973994.26533.269.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-22 at 00:44, Erik Andersen wrote:
> On Wed Aug 21, 2002 at 04:25:39PM -0400, Alan Cox wrote:
> > IDE status
> > 	Chasing two reports of strange ide-scsi crashes
> > 	Still some Promise glitches - need to review merge carefully
> 
> Its doesn't understand that I indeed am using 80 pin cables for
> the drives connected to my Promise 20267 controller.  Also, it would
> be nice to clean up the formatting on the "80-pin cable" message to
> keep it from wrapping.

There is a detection logic error somewhere in the promise driver. Its on
the list to look at if Andre doesnt find it or solve it when he splits
the promise into two drivers (old and new style). If 2.4.20pre2-ac2
worked then it won't be too hard to chase out.

