Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVELMsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVELMsa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 08:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVELMsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 08:48:30 -0400
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:37387 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S261755AbVELMs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 08:48:29 -0400
To: SN <talk2sumit@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Mass Storage
References: <1458d96105051201317c49500c@mail.gmail.com>
From: Douglas McNaught <doug@mcnaught.org>
Date: Thu, 12 May 2005 08:29:34 -0400
In-Reply-To: <1458d96105051201317c49500c@mail.gmail.com> (SN's message of "Thu, 12 May 2005 14:01:35 +0530")
Message-ID: <m2wtq4630x.fsf@Douglas-McNaughts-Powerbook.local>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SN <talk2sumit@gmail.com> writes:

> If I use a USB connected hard-disk (IDE), which device driver would I
> be using? I understand it is recognized as a SCSI disk. So, is it the
> SCSI driver? Or would the IDE driver be used?

It would be the SCSI layer running on top of the USB drivers.  No IDE
involved on the PC side (obviously the USB enclosure has an IDE
controller, but it's driven by the enclsure firmware, not Linux).

-Doug
