Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267762AbUHJWed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267762AbUHJWed (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 18:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267787AbUHJWed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 18:34:33 -0400
Received: from fep16.inet.fi ([194.251.242.241]:975 "EHLO fep16.inet.fi")
	by vger.kernel.org with ESMTP id S267762AbUHJWea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 18:34:30 -0400
From: Jan Knutar <jk-lkml@sci.fi>
To: Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Wed, 11 Aug 2004 01:34:24 +0300
User-Agent: KMail/1.6.2
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk, dwmw2@infradead.org,
       schilling@fokus.fraunhofer.de, axboe@suse.de
References: <1092082920.5761.266.camel@cube>
In-Reply-To: <1092082920.5761.266.camel@cube>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408110134.25537.jk-lkml@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Joerg:
>    "WARNING: Cannot do mlockall(2).\n"
>    "WARNING: This causes a high risk for buffer underruns.\n"
> Fixed:
>    "Warning: You don't have permission to lock memory.\n"
>    "         If the computer is not idle, the CD may be ruined.\n"


Does this also apply if burnproof is in use?




> Joerg:
>    "WARNING: Cannot set priority class parameters priocntl(PC_SETPARMS)\n"
>    "WARNING: This causes a high risk for buffer underruns.\n"
> Fixed:
>    "Warning: You don't have permission to hog the CPU.\n"
>    "         If the computer is not idle, the CD may be ruined.\n"

