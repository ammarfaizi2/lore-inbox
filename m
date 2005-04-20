Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVDTNKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVDTNKy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 09:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVDTNKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 09:10:53 -0400
Received: from extgw-uk.mips.com ([62.254.210.129]:46618 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S261603AbVDTNKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 09:10:50 -0400
Date: Wed, 20 Apr 2005 14:10:25 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Paul Jackson <pj@sgi.com>, ikebe.takashi@lab.ntt.co.jp,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
Message-ID: <20050420131025.GA8255@linux-mips.org>
References: <4263275A.2020405@lab.ntt.co.jp> <20050418040718.GA31163@taniwha.stupidest.org> <4263356D.9080007@lab.ntt.co.jp> <20050418061221.GA32315@taniwha.stupidest.org> <42636285.9060405@lab.ntt.co.jp> <20050418075635.GB644@taniwha.stupidest.org> <20050418021609.07f6ec16.pj@sgi.com> <20050418092505.GA2206@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050418092505.GA2206@taniwha.stupidest.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 02:25:06AM -0700, Chris Wedgwood wrote:

> > The call switching folks have been doing live patching at least
> > since I worked on it, over 25 years ago.  This is not just
> > marketing.
> 
> That still doesn't explain *why* live patching is needed.

The more optimization a modern compiler does the less practical a patching
approach seems for anything but very trivial fixes.

I'd try a shared library based approach for on the fly updates.

  Ralf
