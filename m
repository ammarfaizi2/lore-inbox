Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263535AbTF3P2M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 11:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264590AbTF3P2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 11:28:12 -0400
Received: from cm19173.red.mundo-r.com ([213.60.19.173]:11360 "EHLO
	mail.trasno.org") by vger.kernel.org with ESMTP id S263535AbTF3P2L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 11:28:11 -0400
To: "Brown, Len" <len.brown@intel.com>
Cc: "'Arjan van de Ven'" <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Andrew Morton <akpm@digeo.com>, torvalds@transmeta.com,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] acpismp=force fix
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@trasno.org>
In-Reply-To: <A5974D8E5F98D511BB910002A50A66470B981205@hdsmsx103.hd.intel.com> (Len
 Brown's message of "Thu, 26 Jun 2003 14:37:11 -0700")
References: <A5974D8E5F98D511BB910002A50A66470B981205@hdsmsx103.hd.intel.com>
Date: Mon, 30 Jun 2003 17:42:29 +0200
Message-ID: <863chrshay.fsf@trasno.mitica>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "brown," == Brown, Len <len.brown@intel.com> writes:

Hi

brown,> To disable HT on a uni-processor, wouldn't it be preferable to simply run
brown,> the UP kernel rather than the SMP kernel with HT disabled?  That leaves SMP
brown,> systems, where either the BIOS could disable it (it is a BIOS bug if it
brown,> can't), or as a last resort CONFIG_X86_HT (2.5) could be config'd out of the
brown,> kernel.  I guess I've talked myself into not missing "noht" also.

noht is very useful for distributions, we already have to do a lot of
kernels,  any option that "mandates" to compile a different kernel is
just bad (IMHO).

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
