Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264296AbTLOXLQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 18:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbTLOXLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 18:11:16 -0500
Received: from eta.fastwebnet.it ([213.140.2.50]:41451 "EHLO eta.fastwebnet.it")
	by vger.kernel.org with ESMTP id S264296AbTLOXLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 18:11:12 -0500
From: Emilio Gargiulo <emilio.gargiulo@fastwebnet.it>
To: "Eric Sandeen" <sandeen@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.24-pre1 hangs with XFS on LVM filesystem full
Date: Tue, 16 Dec 2003 00:11:01 +0100
User-Agent: KMail/1.5.4
References: <fa.nj5bn9m.1khkr82@ifi.uio.no> <fa.lsavf2q.25afr8@ifi.uio.no> <pan.2003.12.15.22.29.21.879085@sgi.com>
In-Reply-To: <pan.2003.12.15.22.29.21.879085@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312160011.01810.emilio.gargiulo@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric
I can reproduce on 
/dev/hda10             1772940   1337680    435260  76% /mnt/hda10
and my Linux Box have 256Mb. I'm on a IDE device,  an IBM IC35L120AVVA07-0 
(120Gb).

Also I can reproduce on P4 with 512Mb.

Thanks
Emilio Gargiulo
  
> > It is reproduceable on LVM and on simple partition like /dev/hda10.
>
> Ah, if you can reproduce it on a simple partition, then I'd better
> give it a whirl here.  If you think it has something to do with
> the size of the fs vs. memory, can you post those details
> for your tests?  I.e. how much memory, and how big is the fs where
> you saw the failure?
>
> Thanks,
> -Eric

