Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268213AbUHQMzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268213AbUHQMzO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 08:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268214AbUHQMzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 08:55:14 -0400
Received: from holomorphy.com ([207.189.100.168]:17071 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268213AbUHQMzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 08:55:02 -0400
Date: Tue, 17 Aug 2004 05:54:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm1
Message-ID: <20040817125459.GO11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040816143710.1cd0bd2c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040816143710.1cd0bd2c.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 02:37:10PM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm1
> - perfctr is ready to be merged up, but there are concerns that it
>   duplicates perfmon capabilities, and that perfmon may be a better base from
>   which to start.  Am waiting for the dust to settle on that front.
> - The packet-writing patches should be ready to go, but I haven't even
>   looked at them yet, and am not sure that anyone else has reviewed the code.
> - Added the kprobes facility.

Hmm. Got this on a JS20.


Elapsed time since release of system processors: 0 mins 32 secs

Config file read, 1024 bytes
Welcome
Welcome to yaboot version 1.3.10
Enter "help" to get some basic usage information
boot:
  mm1-2.6.8.1                2.4.21-wired             * 2.4.21-147-pseries64    
  2.4.21-EL-pseries64        wli-2.6.6-rc3-mm1          mm2-2.6.6-rc3           
  virgin-2.6.6-rc3           virgin-2.6.5
boot: mm1-2.6.8.1
Please wait, loading kernel...
   Elf64 kernel loaded...
Looking for displays
OF stdout is    : /vdevice/vty@0
Opening displays...
Hypertas detected, assuming LPAR !
instantiating rtas at 0x0000000007a4e000...rtas_ram_size = 2ea000
fixed_base_addr = 7a4e000
code_base_addr = 7ad8000
Code Image Load Complete.
registered vars:
name                              addr               size  hash align
--------------------------------  ----------------   ----  ---- -----
glob_rtas_trace_buf             : 0000000007a97100  65552     7      0
perf_tools_corr_token_ptr       : 0000000007aabd00      8     7      0
prtas_was_interrupted           : 0000000007aa8100      4     9      1
callperf                        : 0000000007aa8400  12320     9      1
pglob_os_term_state             : 0000000007aab700      4    12      1
hypStopWatch                    : 0000000007aa7400   1800    14      8
prtas_in_progress               : 0000000007aa7e00      4    20      1
bufferstatus                    : 0000000007aac000     40    30      1
last_error_log                  : 0000000007aac500   1024    30      0
perf_tools_buff                 : 0000000007aaba00     88    31      0
nmi_work_buffer                 : 0000000007aad000   4096    31     12
 done
0000000000000000 : booting  cpu /cpus/PowerPC,970@0
0000000000000001 : starting cpu /cpus/PowerPC,970@1... ... done
Calling quiesce ...
returning from prom_init
firmware_features = 0x11ff7f
Starting Linux PPC64 2.6.8.1-mm1
-----------------------------------------------------
naca                          = 0xc000000000004000
naca->pftSize                 = 0x18
naca->debug_switch            = 0x0
naca->interrupt_controller    = 0x2
systemcfg                     = 0xc000000000005000
systemcfg->processorCount     = 0x2
systemcfg->physicalMemorySize = 0x3d000000
systemcfg->dCacheL1LineSize   = 0x80
systemcfg->iCacheL1LineSize   = 0x80
htab_data.htab                = 0x0000000000000000
htab_data.num_ptegs           = 0x20000
-----------------------------------------------------
[boot]0100 MM Init
[boot]0100 MM Init Done
Trap instruction interrupt : Invalid Instruction
[0x0]dummy:
+0x00000000: 00000000   invalid
hdb(0)> 
