Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267216AbTAFXlt>; Mon, 6 Jan 2003 18:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267218AbTAFXlt>; Mon, 6 Jan 2003 18:41:49 -0500
Received: from holomorphy.com ([66.224.33.161]:43394 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267216AbTAFXls>;
	Mon, 6 Jan 2003 18:41:48 -0500
Date: Mon, 6 Jan 2003 15:50:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Chris Wood <cwood@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440)
Message-ID: <20030106235024.GA23814@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Chris Wood <cwood@xmission.com>, linux-kernel@vger.kernel.org
References: <3E1A12B5.4020505@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E1A12B5.4020505@xmission.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 04:35:17PM -0700, Chris Wood wrote:
>   6383 .text.lock.swap                          110.0517
>   4689 .text.lock.vmscan                         28.2470
>   4486 shrink_cache                               4.6729
>    168 rw_swap_page_base                          0.6176
>    124 prune_icache                               0.5167
>     81 statm_pgd_range                            0.1534
>     51 .text.lock.inode                           0.0966
>     38 system_call                                0.6786
>     31 .text.lock.tty_io                          0.0951
>     31 .text.lock.locks                           0.1435
>     18 .text.lock.sched                           0.0373
>     16 _stext                                     0.2000
>     15 fput                                       0.0586
>     11 .text.lock.read_write                      0.0924
>      9 strnicmp                                   0.0703
>      9 do_wp_page                                 0.0110
>      9 do_page_fault                              0.0066
>      9 .text.lock.namei                           0.0073
>      9 .text.lock.fcntl                           0.0714
>      8 sys_read                                   0.0294

This is really bad lock contention. You may need 2.5.x.


Bill
