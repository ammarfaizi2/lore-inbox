Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264508AbTDPSuY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 14:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbTDPSuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 14:50:24 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:46350 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264508AbTDPSuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 14:50:23 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Steffen Moser <lists@steffen-moser.de>
Subject: Re: 2.4.x Problem with cd writing
Date: Wed, 16 Apr 2003 20:58:29 +0200
User-Agent: KMail/1.5
References: <200304161919.08615.fsdeveloper@yahoo.de> <20030416181005.GB9662@steffen-moser.de>
In-Reply-To: <20030416181005.GB9662@steffen-moser.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304162058.29367.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 April 2003 20:10, Steffen Moser wrote:
> * On Wed, Apr 16, 2003 at 07:19 PM (+0200), Michael Buesch wrote:
> > While my writer writes TOC or fixes CD (doesn't write real data-stream),
> > the whole ide-disk interface of the system is frozen.
>
> Are you sure that the whole IDE subsystem freezes? I suppose that only
> the IDE channel where the CD writer is connected to becomes frozen
No, both channels are frozen.

> You can try the option "-immed" which is available at least when using
> "cdrecord-2.0" [1].
sorry, doesn't work.

-- 
Regards Michael Buesch.
http://www.8ung.at/tuxsoft

$ cat /dev/zero > /dev/null
/dev/null: That's *not* funny! :(

