Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267426AbTBUM54>; Fri, 21 Feb 2003 07:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267427AbTBUM54>; Fri, 21 Feb 2003 07:57:56 -0500
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:18255 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S267426AbTBUM5y>; Fri, 21 Feb 2003 07:57:54 -0500
From: Bob Johnson <livewire@gentoo.org>
Reply-To: livewire@gentoo.org
To: <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] TIObench 2.5.60 performance
Date: Fri, 21 Feb 2003 08:05:39 -0500
User-Agent: KMail/1.5
References: <94F20261551DC141B6B559DC4910867217CCBE@blr-m3-msg.wipro.com>
In-Reply-To: <94F20261551DC141B6B559DC4910867217CCBE@blr-m3-msg.wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302210805.39508.livewire@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My Tiobenchs on raid0 are quite a bit slower with 2.5.62 then 2.4.20 vanilla  
:(
average 50m/sec on 2.4
average 28m/sec on 2.5.62 
hdparm shows similiar results.

On Friday 21 February 2003 05:43 am, Aniruddha M Marathe wrote:
> Here is TIObench performance of 2.5.62. Comparison of 2.5.62 and 2.5.60 is
> given below.
>
>
>
> ---------------------------------------------------------------------------
>-------------------------------------- test					2.5.62 (as compared to
> 					2.5.60) APPROXIMATE % change
> ---------------------------------------------------------------------------
>------------------------------------- rate (megabytes per second)		less than
> 5% increase
> CPU % utilization			less than 5% increase
> Average Latency			5 % decrease
> Maximum latency			5-10 % increase
> CPU efficiency				less than 5% increase
> ---------------------------------------------------------------------------
>--------------------------------------
>
>
> ************************************************************
> 		TIObench for kernel 2.5.62
> ************************************************************
> No size specified, using 252 MB
>
> Unit information
> ================
> File size = megabytes
> Blk Size  = bytes
> Rate      = megabytes per second
> CPU%      = percentage of CPU used during the test
> Latency   = milliseconds
> Lat%      = percent of requests that took longer than X seconds
> CPU Eff   = Rate divided by CPU% - throughput per cpu load
>
> Sequential Reads
>                               File  Blk   Num                   Avg     
> Maximum      Lat%     Lat%    CPU Identifier                    Size  Size 
> Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
> ---------------------------- ------ ----- ---  ------ ------ ---------
> -----------  -------- -------- ----- 2.5.62                        252  
> 4096   10    7.93 4.271%    12.438     2841.36   0.00000  0.00000   186
>
> Random Reads
>                               File  Blk   Num                   Avg     
> Maximum      Lat%     Lat%    CPU Identifier                    Size  Size 
> Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
> ---------------------------- ------ ----- ---  ------ ------ ---------
> -----------  -------- -------- ----- 2.5.62                        252  
> 4096   10    0.47 0.552%   213.629     1301.68   0.00000  0.00000    84
>
> Sequential Writes
>                               File  Blk   Num                   Avg     
> Maximum      Lat%     Lat%    CPU Identifier                    Size  Size 
> Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
> ---------------------------- ------ ----- ---  ------ ------ ---------
> -----------  -------- -------- ----- 2.5.62                        252  
> 4096   10   12.39 21.14%     6.214    37150.05   0.10157  0.00782    59
>
> Random Writes
>                               File  Blk   Num                   Avg     
> Maximum      Lat%     Lat%    CPU Identifier                    Size  Size 
> Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
> ---------------------------- ------ ----- ---  ------ ------ ---------
> -----------  -------- -------- ----- 2.5.62                        252  
> 4096   10    0.73 0.891%     0.762     1761.34   0.00000  0.00000    81 No
> size specified, using 252 MB
>
> Aniruddha Marathe
> WIPRO Technologies, India.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

