Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319141AbSIDLSS>; Wed, 4 Sep 2002 07:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319136AbSIDLSS>; Wed, 4 Sep 2002 07:18:18 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:47603
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319135AbSIDLSR>; Wed, 4 Sep 2002 07:18:17 -0400
Subject: Re: aic7xxx sets CDR offline, how to reset?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <20020904103737.GA9936@win.tue.nl>
References: <dledford@redhat.com> <20020903171321.A12201@redhat.com>
	<200209032148.g83LmeP09177@localhost.localdomain> 
	<20020904103737.GA9936@win.tue.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 04 Sep 2002 12:23:13 +0100
Message-Id: <1031138593.2788.40.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-04 at 11:37, Andries Brouwer wrote:
> The scsi error recovery has many bad properties, but one is its slowness.
> Once it gets triggered on a machine with SCSI disks it is common to
> have a dead system for several minutes. I have not yet met a situation
> in which rebooting was not preferable above scsi error recovery,
> especially since the attempt to recover often fails.

Well I for one prefer the scsi timeout/abort sequence on a CD getting
confused badly by a bad block (as at least some of my drives do) to a
reboot everytime I get bad media

