Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261862AbSJZGAE>; Sat, 26 Oct 2002 02:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261863AbSJZGAE>; Sat, 26 Oct 2002 02:00:04 -0400
Received: from sccimhc01.insightbb.com ([63.240.76.163]:49375 "EHLO
	sccimhc01.insightbb.com") by vger.kernel.org with ESMTP
	id <S261862AbSJZGAE>; Sat, 26 Oct 2002 02:00:04 -0400
Message-ID: <3DB9EB82.7060106@insightbb.com>
Date: Sat, 26 Oct 2002 01:10:26 +0000
From: Mike Tharp <mtharp@insightbb.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: make xconfig - 2.5.44
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe this has already been addressed.  I looked for a solution like 
crazy first.  Trying to configure 2.5.44.  "make menuconfig" works fine 
to my knowledge.

-Mike Tharp
---------------------------
make xconfig

make -f scripts/Makefile scripts/kconfig.tk
  Generating scripts/kconfig.tk
drivers/pnp/Config.in: 7: can't handle dep_bool/dep_mbool/dep_tristate 
condition
wish -f scripts/kconfig.tk
Error in startup script: invalid command name "clear_choices"
    while executing
"clear_choices"
    (procedure "read_config" line 3)
    invoked from within
"read_config $defaults"
    invoked from within
"if { [file readable .config] == 1} then {
        if { $argc > 0 } then {
                if { [lindex $argv 0] != "-D" } then {
                        read_config .config
                }
                else
                {
                        r..."
    (file "scripts/kconfig.tk" line 646)
make: *** [xconfig] Error 1

