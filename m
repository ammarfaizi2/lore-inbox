Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264780AbUEYUER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264780AbUEYUER (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 16:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbUEYUEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 16:04:16 -0400
Received: from mail1.kontent.de ([81.88.34.36]:8862 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264780AbUEYUEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 16:04:15 -0400
From: Oliver Neukum <oliver@neukum.org>
To: root@chaos.analogic.com
Subject: Re: very low performance on SCSI disks if device node is in tmpfs
Date: Tue, 25 May 2004 22:02:54 +0200
User-Agent: KMail/1.6.2
Cc: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org
References: <20040525184732.GB26661@suse.de> <20040525193458.GA21120@suse.de> <Pine.LNX.4.53.0405251540410.803@chaos>
In-Reply-To: <Pine.LNX.4.53.0405251540410.803@chaos>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200405252202.54745.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 25. Mai 2004 21:44 schrieb Richard B. Johnson:
> On Tue, 25 May 2004, Olaf Hering wrote:
> 
> >  On Tue, May 25, Richard B. Johnson wrote unrelated stuff:
> >
> 
> It is not unrelated stuff. If you think it is, you will
> come to an incorrect conclusion with your experiments.
> As I stated, you are not actually communicating with a
> device-file except for the initial open().

Exactly therefore the results are so extremely odd.
Either looking up a device node is very expensive, or we have an
unknown phenomenon.

	Regards
		Oliver
