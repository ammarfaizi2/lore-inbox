Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264502AbUIITj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUIITj3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUIITiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:38:15 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:13787 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S266748AbUIITJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:09:00 -0400
Date: Thu, 9 Sep 2004 21:07:57 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [4/2] consolidate __task_mem() and __task_mem_cheap()
Message-ID: <20040909190757.GA30582@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
References: <20040908184028.GA10840@k3.hellgate.ch> <20040908184130.GA12691@k3.hellgate.ch> <20040909003529.GI3106@holomorphy.com> <20040909184300.GA28278@k3.hellgate.ch> <20040909184933.GG3106@holomorphy.com> <20040909190024.GH3106@holomorphy.com> <20040909190214.GI3106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909190214.GI3106@holomorphy.com>
X-Operating-System: Linux 2.6.9-rc1-bk13 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Sep 2004 12:02:14 -0700, William Lee Irwin III wrote:
> +		stats->vmrss += mm->end_code - mm->start_code;

s/vmrss/vmsize/ ?
