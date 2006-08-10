Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWHJTvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWHJTvG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWHJTuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:50:32 -0400
Received: from ns.suse.de ([195.135.220.2]:48278 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932078AbWHJTu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:50:26 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH for review] [3/145] i386: Allow to use GENERICARCH for UP kernels
Date: Thu, 10 Aug 2006 21:50:15 +0200
User-Agent: KMail/1.9.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Keith Mannthey <kmannth@us.ibm.com>
References: <20060810 935.775038000@suse.de> <20060810193515.0E65213B90@wotan.suse.de> <1155239251.19249.268.camel@localhost.localdomain>
In-Reply-To: <1155239251.19249.268.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608102150.15237.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why does this particular loop have to go?  I'm sure it's OK, but I also
> wonder if there is a nice way to do it without the #ifdef.

My memory is fuzzy because that is actually an quite old patch. But I think
it was to avoid some dependency issue with needing something that wasn't
available on the UP kernel.

If you know of a nicer way to do this please submit a patch.

-Andi
