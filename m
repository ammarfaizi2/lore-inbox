Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWGGCbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWGGCbN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 22:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWGGCbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 22:31:13 -0400
Received: from pat.uio.no ([129.240.10.4]:48288 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751146AbWGGCbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 22:31:12 -0400
Subject: Re: ext4 features
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <44ADC3CE.1030302@tmr.com>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	 <20060704010240.GD6317@thunk.org> <44ABAF7D.8010200@tmr.com>
	 <20060705125956.GA529@fieldses.org> <44AC2B56.8010703@tmr.com>
	 <20060705214133.GA28487@fieldses.org>  <44AC7647.2080005@tmr.com>
	 <1152189796.5689.17.camel@lade.trondhjem.org>  <44ADC3CE.1030302@tmr.com>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 22:30:47 -0400
Message-Id: <1152239447.6092.12.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.863, required 12,
	autolearn=disabled, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 22:15 -0400, Bill Davidsen wrote:
> Trond Myklebust wrote:
> 
> >Nobody gives a rats arse about backups: those are infrequent and
> >can/should use more sophisticated techniques such as checksumming.
> >
> Actually, those of us who do run production servers care vastly about 
> backups. And beside being utterly unscalable (checksum 20 TB of files 
> four times a day to find what changed???), you would have to remember 
> the checksums for all those files.

It is trivial to check if your last backup of the file was started
within 1 second or so of the last change made to the file, in which case
your backup program needs to perform a more thorough check. That sort of
thing is possible when you are talking about a daily (or even hourly)
backup.

Cheers,
  Trond

