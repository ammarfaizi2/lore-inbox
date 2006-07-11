Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWGKLSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWGKLSP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 07:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWGKLSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 07:18:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:5033 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751041AbWGKLSO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 07:18:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=D8zFYVVsFd6dS8rX298ahPL6Tcr5lmgPYkqoAIUd1FC71KVUKuUnAFbTV5wSPTWCOB/CGWVPmKc0OhiKcc19uXthPZqpJ478iK9TyBvqZBjO1C4TBL4NlGnlyeLxr4tLS430q2ZDGcG752YoY4zUaRY4NxUhAxZU81nQSgZwWho=
Date: Tue, 11 Jul 2006 13:18:05 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Jaroslav Kysela <perex@suse.cz>
Cc: atlka@pg.gda.pl, rlrevell@joe-job.com, galibert@pobox.com,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round (v2)
Message-Id: <20060711131805.543307f8.diegocg@gmail.com>
In-Reply-To: <Pine.LNX.4.61.0607111110280.9147@tm8103.perex-int.cz>
References: <20060707231716.GE26941@stusta.de>
	<p737j2potzr.fsf@verdi.suse.de>
	<1152458300.28129.45.camel@mindpipe>
	<20060710132810.551a4a8d.atlka@pg.gda.pl>
	<1152571717.19047.36.camel@mindpipe>
	<44B2E4FF.9000502@pg.gda.pl>
	<20060710235934.GC26528@dspnet.fr.eu.org>
	<1152578344.21909.12.camel@mindpipe>
	<20060711085952.f1254229.atlka@pg.gda.pl>
	<Pine.LNX.4.61.0607110937160.9147@tm8103.perex-int.cz>
	<20060711110811.947e15ed.atlka@pg.gda.pl>
	<Pine.LNX.4.61.0607111110280.9147@tm8103.perex-int.cz>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 11 Jul 2006 11:52:56 +0200 (CEST),
Jaroslav Kysela <perex@suse.cz> escribió:


> > Kernel redirector is not a bad solution - there should be some kind of 
> > interface for such redirectors for different purposes. netlink device 
> > maybe? For example you should redirect all these traffic to some RT 
> > daemon doing all job.
> 
> I would prefer probably a network lowlevel ALSA driver. You'll get the 
> network transparency as benefit.


Shouldn't the plan9 filesystem (the implementation merged in Linux) be able
to do networking transparency already? It should be able to export /dev
devices nodes through the network transparently, AFAIK.
