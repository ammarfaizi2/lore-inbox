Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136047AbRDVL5k>; Sun, 22 Apr 2001 07:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136048AbRDVL5b>; Sun, 22 Apr 2001 07:57:31 -0400
Received: from ns.caldera.de ([212.34.180.1]:61962 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S136047AbRDVL5V>;
	Sun, 22 Apr 2001 07:57:21 -0400
Date: Sun, 22 Apr 2001 13:56:43 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: rwsem.o listed twice as export-objs
Message-ID: <20010422135643.A3354@caldera.de>
Mail-Followup-To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
In-Reply-To: <20010420215330.N682@nightmaster.csn.tu-chemnitz.de> <200104211606.SAA06630@ns.caldera.de> <20010421201815.U719@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20010421201815.U719@nightmaster.csn.tu-chemnitz.de>; from ingo.oeser@informatik.tu-chemnitz.de on Sat, Apr 21, 2001 at 08:18:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2001 at 08:18:15PM +0200, Ingo Oeser wrote:
> On Sat, Apr 21, 2001 at 06:06:34PM +0200, Christoph Hellwig wrote:
> > In article <20010420215330.N682@nightmaster.csn.tu-chemnitz.de> you wrote:
> > > please remove rwsem.o from the list of exported objects, if it is
> > > not used.
> > 
> > No!  The whole point of 'export-objs' is to _always_ list the objects there
> > to make the makefiles smaller and cleaner.
> 
> Ok, so this patch is better?

Yes.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
