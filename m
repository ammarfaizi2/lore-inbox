Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbTEVSq0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 14:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbTEVSq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 14:46:26 -0400
Received: from holomorphy.com ([66.224.33.161]:58765 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263103AbTEVSq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 14:46:26 -0400
Date: Thu, 22 May 2003 11:59:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: mikpe@csd.uu.se
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: arch/i386/kernel/mpparse.c warning fixes
Message-ID: <20030522185921.GW8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	mikpe@csd.uu.se, akpm@digeo.com, linux-kernel@vger.kernel.org
References: <20030522155320.GP29926@holomorphy.com> <16076.62927.525714.113342@gargle.gargle.HOWL> <20030522162305.GT8978@holomorphy.com> <16077.5909.155004.502440@gargle.gargle.HOWL> <20030522183608.GV8978@holomorphy.com> <16077.7101.339611.256918@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16077.7101.339611.256918@gargle.gargle.HOWL>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 08:49:33PM +0200, mikpe@csd.uu.se wrote:
> Ah, so it's a workaround to silence a compiler warning on char > 256.
> Frankly, I'd rather see a cast there in this case. I.e.,
> 	 (unsigned int)m->mpc_apicid >= MAX_APICS
> or something like that, with a suitable comment.

Already tried it. It does not suffice to silence the compiler.


-- wli
