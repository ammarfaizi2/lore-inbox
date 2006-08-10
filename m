Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161084AbWHJGYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161084AbWHJGYa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161082AbWHJGY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:24:29 -0400
Received: from cantor.suse.de ([195.135.220.2]:39648 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161079AbWHJGY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:24:28 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Merging libata PATA support into the base kernel
References: <1155144599.5729.226.camel@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 10 Aug 2006 08:24:27 +0200
In-Reply-To: <1155144599.5729.226.camel@localhost.localdomain>
Message-ID: <p733bc5nm5g.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> - No support for host-protected-area yet

Even the support in the old one for that wasn't complete. It didn't
redo the HPA disabling on resume-from-ram, which made parts of the
disk not accessible anymore after wakeup. So at least on laptops it
always had to be disabled anyways.

-Andi
