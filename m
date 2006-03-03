Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752193AbWCCJPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193AbWCCJPM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 04:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752196AbWCCJPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 04:15:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48003 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752193AbWCCJPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 04:15:10 -0500
Subject: Re: SEEK_HOLE and SEEK_DATA support?
From: Arjan van de Ven <arjan@infradead.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jim Dennis <jimd@starshine.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1141374797.3042.95.camel@mindpipe>
References: <20060302214929.GA16523@starshine.org>
	 <1141374797.3042.95.camel@mindpipe>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 10:15:05 +0100
Message-Id: <1141377306.2883.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-03 at 03:33 -0500, Lee Revell wrote:
> On Thu, 2006-03-02 at 13:49 -0800, Jim Dennis wrote:
> > 
> >  I ask primarily because of the interplay between 64-bit systems and
> >  things like /var/log/lastlog (which appears as a 1.2TiB file due to
> >  the nfsnobody UID of 4294967294).
> > 
> >  (I'm realize that adding support for these additional seek() flags
> >  wouldn't solve the problem ... archiving tools would still have to
> >  implement it.  And I can also hear the argument that Red Hat and other
> >  distributions should re-implement lastlog handling to use a more modern
> >  and efficient hashing/index format and perhaps that they should set
> >  nfsnobody to "-1" ... 
> 
> So the presence of very high UIDs causes lastlog to be huge?  That just
> sounds like a RedHat bug.
 it causes it to be a sparse file

lastlog is an array based file format ;)
but sparse

