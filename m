Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268421AbTBNOlt>; Fri, 14 Feb 2003 09:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268422AbTBNOlt>; Fri, 14 Feb 2003 09:41:49 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:47028 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S268421AbTBNOlr>;
	Fri, 14 Feb 2003 09:41:47 -0500
Date: Fri, 14 Feb 2003 15:51:35 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CFQ scheduler, #2
Message-ID: <20030214145135.GQ879@suse.de>
References: <20030214141919.GK879@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030214141919.GK879@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14 2003, Jens Axboe wrote:
> Obligatory contest results.

Agrh, old scores (not the fr2). Here's for the version sent out:

no_load:
Kernel        [runs]    Time    CPU%    Loads   LCPU%   Ratio
2.5.60             2    31      177.4   0       0.0     1.00
2.5.60-cfq-fr      2    31      177.4   0       0.0     1.00
2.5.60-mm1         2    32      171.9   0       0.0     1.00
cacherun:
Kernel        [runs]    Time    CPU%    Loads   LCPU%   Ratio
2.5.60             2    29      182.8   0       0.0     0.94
2.5.60-cfq-fr      2    29      182.8   0       0.0     0.94
2.5.60-mm1         2    29      186.2   0       0.0     0.91
process_load:
Kernel        [runs]    Time    CPU%    Loads   LCPU%   Ratio
2.5.60             2    38      142.1   12      47.4    1.23
2.5.60-cfq-fr      2    38      142.1   12      47.4    1.23
2.5.60-mm1         2    38      142.1   13      50.0    1.19
ctar_load:
Kernel        [runs]    Time    CPU%    Loads   LCPU%   Ratio
2.5.60             2    38      147.4   0       0.0     1.23
2.5.60-cfq-fr      2    38      147.4   0       0.0     1.23
2.5.60-mm1         2    36      155.6   0       0.0     1.12
xtar_load:
Kernel        [runs]    Time    CPU%    Loads   LCPU%   Ratio
2.5.60             2    40      140.0   0       2.5     1.29
2.5.60-cfq-fr      2    38      147.4   0       2.6     1.23
2.5.60-mm1         2    39      143.6   0       2.6     1.22
io_load:
Kernel        [runs]    Time    CPU%    Loads   LCPU%   Ratio
2.5.60             2    93      61.3    2       14.0    3.00
2.5.60-cfq-fr      2    71      78.9    1       8.1     2.29
2.5.60-mm1         2    82      69.5    1       9.8     2.56
read_load:
Kernel        [runs]    Time    CPU%    Loads   LCPU%   Ratio
2.5.60             2    40      140.0   0       5.0     1.29
2.5.60-cfq-fr      2    41      136.6   0       4.9     1.32
2.5.60-mm1         2    38      147.4   0       2.6     1.19
list_load:
Kernel        [runs]    Time    CPU%    Loads   LCPU%   Ratio
2.5.60             2    35      157.1   0       8.6     1.13
2.5.60-cfq-fr      2    34      161.8   0       8.8     1.10
2.5.60-mm1         2    34      164.7   0       8.8     1.06
mem_load:
Kernel        [runs]    Time    CPU%    Loads   LCPU%   Ratio
2.5.60             2    50      116.0   75      10.0    1.61
2.5.60-cfq-fr      2    47      123.4   74      10.6    1.52
2.5.60-mm1         2    52      113.5   77      9.4     1.62
dbench_load:
Kernel        [runs]    Time    CPU%    Loads   LCPU%   Ratio
2.5.60             2    36      155.6   12693   27.8    1.16
2.5.60-cfq-fr      2    35      157.1   11368   25.7    1.13
2.5.60-mm1         2    35      160.0   12486   28.6    1.09

-- 
Jens Axboe

