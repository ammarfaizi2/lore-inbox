Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263651AbTJRAMQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 20:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbTJRAMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 20:12:16 -0400
Received: from holomorphy.com ([66.224.33.161]:9866 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263628AbTJRAMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 20:12:14 -0400
Date: Fri, 17 Oct 2003 17:15:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] prevent "dd if=/dev/mem" crash
Message-ID: <20031018001511.GG25291@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200310171610.36569.bjorn.helgaas@hp.com> <20031017155028.2e98b307.akpm@osdl.org> <200310171725.10883.bjorn.helgaas@hp.com> <20031017165543.2f7e9d49.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031017165543.2f7e9d49.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 04:55:43PM -0700, Andrew Morton wrote:
> This code was conceived before my time and I don't recall seeing much
> discussion, so this is all guesswork..
> I'd say that the high_memory test _is_ superfluous and that if anyone
> cared, we would remove it and establish a temporary pte against the address if
> it was outside the direct-mapped area.  But nobody cares enough to have
> done anything about it.

I've heard crash dump people mention it and am trying to convince them
to post their fix(es) here. =)


-- wli
