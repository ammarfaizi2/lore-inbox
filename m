Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263164AbTCYSCd>; Tue, 25 Mar 2003 13:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263182AbTCYSCd>; Tue, 25 Mar 2003 13:02:33 -0500
Received: from holomorphy.com ([66.224.33.161]:38050 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263164AbTCYSCc>;
	Tue, 25 Mar 2003 13:02:32 -0500
Date: Tue, 25 Mar 2003 10:13:13 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: fix unuse_pmd() OOM handling
Message-ID: <20030325181313.GK30140@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>, akpm@zip.com.au,
	linux-kernel@vger.kernel.org
References: <20030325170139.GK1350@holomorphy.com> <Pine.LNX.4.44.0303251801530.10350-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303251801530.10350-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Mar 2003, William Lee Irwin III wrote:
>> Fix unuse_pmd() OOM handling for pte_chain_alloc() failures.
>> Unfortunately I'm not able to trigger anything more than light
>> swapping loads to test this with.

On Tue, Mar 25, 2003 at 06:04:09PM +0000, Hugh Dickins wrote:
> Sorry, Bill: please ignore this one, Andrew: I'm preparing a
> better patch for this, extracted from my anobjrmap patches.

This stuff was relatively brutally crowbarred in. Go ahead and
send it in, I'd actually rather have rmap_get_cpu() than this.


-- wli
