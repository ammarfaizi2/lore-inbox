Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263832AbTIBRwh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 13:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263753AbTIBRuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 13:50:16 -0400
Received: from holomorphy.com ([66.224.33.161]:25218 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263832AbTIBRcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 13:32:33 -0400
Date: Tue, 2 Sep 2003 10:33:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Stuart Low <stuart@perlboy.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [DEBUG] 2.6.0-test4 - sleeping function called from invalid context
Message-ID: <20030902173320.GM4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Stuart Low <stuart@perlboy.org>, linux-kernel@vger.kernel.org
References: <1062520736.2331.10.camel@poohbox.perlaholic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062520736.2331.10.camel@poohbox.perlaholic.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 02:38:56AM +1000, Stuart Low wrote:
> - -snip- -
> nvidia: no version magic, tainting kernel.
> nvidia: module license 'NVIDIA' taints kernel.
> 0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496 
> Wed Jul 16 19:03:09 PDT 2003
> Debug: sleeping function called from invalid context at mm/slab.c:1817

Looks very much like an nvidia problem; best to report it to them.


-- wli
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Wed, Sep 03, 2003 at 02:38:56AM +1000, Stuart Low wrote:
> - -snip- -
> nvidia: no version magic, tainting kernel.
> nvidia: module license 'NVIDIA' taints kernel.
> 0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496 
> Wed Jul 16 19:03:09 PDT 2003
> Debug: sleeping function called from invalid context at mm/slab.c:1817

Looks very much like an nvidia problem; best to report it to them.


-- wli
