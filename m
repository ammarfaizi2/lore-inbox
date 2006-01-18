Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030402AbWARTuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030402AbWARTuk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 14:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030404AbWARTuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 14:50:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36333 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030402AbWARTuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 14:50:39 -0500
Subject: Re: RFC [patch 00/34] PID Virtualization Overview
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Serge Hallyn <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
In-Reply-To: <1137613088.24321.60.camel@localhost.localdomain>
References: <20060117143258.150807000@sergelap>
	 <43CD18FF.4070006@FreeBSD.org>
	 <1137517698.8091.29.camel@localhost.localdomain>
	 <43CD32F0.9010506@FreeBSD.org>
	 <1137521557.5526.18.camel@localhost.localdomain>
	 <1137522550.14135.76.camel@localhost.localdomain>
	 <1137610912.24321.50.camel@localhost.localdomain>
	 <1137612537.3005.116.camel@laptopd505.fenrus.org>
	 <1137613088.24321.60.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 20:50:35 +0100
Message-Id: <1137613835.3005.120.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 11:38 -0800, Dave Hansen wrote:
> On Wed, 2006-01-18 at 20:28 +0100, Arjan van de Ven wrote:
> > On Wed, 2006-01-18 at 11:01 -0800, Dave Hansen wrote:
> > > Other than searches, there appear to be quite a number of drivers an
> > > subsystems that like to print out pids.  I can't find any cases yet
> > > where these are integral to functionality, but I wonder what approach we
> > > should take. 
> > 
> > those should obviously print out the REAL pid, not the application
> > pid ... so no changes needed.
> 
> One suggestion was to make all pid comparisons meaningless without some
> kind of "container" context along with it.  The thought is that using
> pids is inherently racy

current->pid sure isn't racey, you yourself KNOW you're not going
away :)





