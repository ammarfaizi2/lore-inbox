Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbVJGOZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbVJGOZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbVJGOZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:25:57 -0400
Received: from ns.firmix.at ([62.141.48.66]:16800 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S964870AbVJGOZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:25:56 -0400
Subject: Re: 'Undeleting' an open file
From: Bernd Petrovitsch <bernd@firmix.at>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8qo997np4h6n.1ihs13ptrx2y2.dlg@40tude.net>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it>
	 <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix>
	 <4343E611.1000901@perkel.com> <20051005144441.GC8011@csclub.uwaterloo.ca>
	 <4343E7AC.6000607@perkel.com> <20051005153727.994c4709.fmalita@gmail.com>
	 <43442D19.4050005@perkel.com> <Pine.LNX.4.58.0510052208130.4308@be1.lrz>
	 <8qo997np4h6n.1ihs13ptrx2y2.dlg@40tude.net>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Fri, 07 Oct 2005 16:25:40 +0200
Message-Id: <1128695140.31606.50.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-07 at 16:14 +0200, Giuseppe Bilotta wrote:
> On Wed, 5 Oct 2005 23:05:34 +0200 (CEST), Bodo Eggert wrote:
> 
> > Files are deleted if the last reference is gone. If you play a music file
> > and unlink it while it's playing, it won't be deleted untill the player
> > closes the file, since an open filehandle is a reference.
> 
> BTW, I've always wondered: is there a way to un-unlink such a file?

Legally not.
You could turn off the power and do a fsck on a not-journalling
filesystem. But even then it is not sure ...

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

