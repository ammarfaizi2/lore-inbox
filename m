Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbTDVNHe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 09:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbTDVNHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 09:07:34 -0400
Received: from holomorphy.com ([66.224.33.161]:3226 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263126AbTDVNHd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 09:07:33 -0400
Date: Tue, 22 Apr 2003 06:19:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: pgcl-2.5.68-1
Message-ID: <20030422131914.GE8931@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20030422122747.GD8931@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030422122747.GD8931@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 05:27:47AM -0700, William Lee Irwin III wrote:
> Results:
[...]
> HighTotal:    65198080 kB
> HighFree:     65131968 kB
> LowTotal:       751872 kB
> LowFree:        708480 kB
[...]
> LowFree remains above 700MB, as compared to under 200MB on mainline.

The point of the tree (I guess it's big enough to call a tree instead
of a patch) being, from the POV of my funding sources etc., that 64GB
i386 has significant amounts of lowmem pressure alleviated and so the
machines are actually able to support various workloads for which they
were intended. If you've got >= 16GB of highmem, you should be
extremely interested in this patch.

It also increases maximum fs blocksize, which was its original purpose
as it was conceived by Hugh Dickins in his 2.4.6/2.4.7 patches (and his
2.4.x implementation was in many ways superior to my own).


-- wli
