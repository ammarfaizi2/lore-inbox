Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUDGT1b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 15:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264158AbUDGT1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 15:27:31 -0400
Received: from holomorphy.com ([207.189.100.168]:19591 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264153AbUDGT1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 15:27:30 -0400
Date: Wed, 7 Apr 2004 12:27:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mc2
Message-ID: <20040407192727.GE30117@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040406221744.2bd7c7e4.akpm@osdl.org> <20040407180430.GA30117@holomorphy.com> <20040407180919.GB30117@holomorphy.com> <20040407112738.23d07088.akpm@osdl.org> <20040407183416.GC30117@holomorphy.com> <20040407115247.701ae24a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407115247.701ae24a.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 11:52:47AM -0700, Andrew Morton wrote:
> The compiler has ((int)-1) and then has to promote it to ULL.  If it does
> the conversion to unsigned before the conversion to long long, we lose. 
> But it doesn't, and I couldn't immediately find a spec which justfies this
> behaviour.

If it works with gcc, it's good enough for me.


-- wli
