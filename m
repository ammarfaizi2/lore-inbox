Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbTLAVoL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 16:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264296AbTLAVoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 16:44:11 -0500
Received: from dci.doncaster.on.ca ([66.11.168.194]:22713 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S264286AbTLAVoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 16:44:09 -0500
To: Samuel Flory <sflory@rackable.com>
Cc: Greg Stark <gsstark@mit.edu>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata in 2.4.24?
References: <Pine.LNX.4.44.0312010836130.13692-100000@logos.cnet>
	<3FCB8312.3050703@rackable.com> <87fzg4ckej.fsf@stark.dyndns.tv>
	<3FCBB15F.7050505@rackable.com>
In-Reply-To: <3FCBB15F.7050505@rackable.com>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 01 Dec 2003 16:44:07 -0500
Message-ID: <87ad6ccixk.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Samuel Flory <sflory@rackable.com> writes:

>    What chipset are you using?  Assumming that hda is your sata drive. What are
> the results of the following "hdarm -t /dev/hda" "hdparm -dvi /dev/hda"   The
> ICH5 chipset is the only chipset I've found that works well without libata.

Ah, my motherboard is in fact an ICH5 I believe.
Incidentally my kernel is actually 2.4.23-pre4.

Is there any documentation about what libata is and what it does differently
from the stock kernel? Why is it being developed separately instead of as a
set of new drivers in the kernel like normal? 

-- 
greg

