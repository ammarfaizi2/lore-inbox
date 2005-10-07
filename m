Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbVJGPvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbVJGPvw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 11:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030467AbVJGPvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 11:51:52 -0400
Received: from ns.firmix.at ([62.141.48.66]:24736 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1750965AbVJGPvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 11:51:51 -0400
Subject: Re: 'Undeleting' an open file
From: Bernd Petrovitsch <bernd@firmix.at>
To: Alex Riesen <raa.lkml@gmail.com>
Cc: Ian Campbell <ijc@hellion.org.uk>, Giuseppe Bilotta <bilotta78@hotpop.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <81b0412b0510070814v769ddb11n7e0d812a09bdf77b@mail.gmail.com>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4343E611.1000901@perkel.com>
	 <20051005144441.GC8011@csclub.uwaterloo.ca> <4343E7AC.6000607@perkel.com>
	 <20051005153727.994c4709.fmalita@gmail.com> <43442D19.4050005@perkel.com>
	 <Pine.LNX.4.58.0510052208130.4308@be1.lrz>
	 <8qo997np4h6n.1ihs13ptrx2y2.dlg@40tude.net>
	 <1128695400.28620.42.camel@icampbell-debian>
	 <1128696194.31606.53.camel@tara.firmix.at>
	 <81b0412b0510070814v769ddb11n7e0d812a09bdf77b@mail.gmail.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Fri, 07 Oct 2005 17:51:26 +0200
Message-Id: <1128700286.31606.56.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-07 at 17:14 +0200, Alex Riesen wrote:
> On 10/7/05, Bernd Petrovitsch <bernd@firmix.at> wrote:
> > > > > Files are deleted if the last reference is gone. If you play a music file
> > > > > and unlink it while it's playing, it won't be deleted untill the player
> > > > > closes the file, since an open filehandle is a reference.
> > > > BTW, I've always wondered: is there a way to un-unlink such a file?
> > > Access via /proc/PID/fd/* seems to work:
> > Did you try linking it?
> >
> 
> ln: creating hard link `testfile2' to `/proc/14282/fd/3': Invalid
> cross-device link
> Pity :)
> "cp" works, btw.

Yup.
<anal>But then it is not un-unlinking and you get another file.</anal>

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

