Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTGAKyo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 06:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTGAKyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 06:54:44 -0400
Received: from holomorphy.com ([66.224.33.161]:23982 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262123AbTGAKyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 06:54:43 -0400
Date: Tue, 1 Jul 2003 04:08:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.73-mm2
Message-ID: <20030701110858.GF26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030701105134.GE26348@holomorphy.com> <Pine.LNX.4.44.0307011202550.1217-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307011202550.1217-100000@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jul 2003, William Lee Irwin III wrote:
>> Well, I was mostly looking for getting handed back 0 when lowmem is
>> empty; I actually did realize they didn't give entirely accurate counts
>> of free lowmem pages.

On Tue, Jul 01, 2003 at 12:08:03PM +0100, Hugh Dickins wrote:
> I'm not pleading for complete accuracy, but nr_free_buffer_pages()
> will never hand back 0 (if your system managed to boot).
> It's a static count of present_pages (adjusted), not of
> free pages.  Or am I misreading nr_free_zone_pages()?

You're right. Wow, that's even more worse than I suspected.


-- wli
