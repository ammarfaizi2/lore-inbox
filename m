Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265568AbSJSJKP>; Sat, 19 Oct 2002 05:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265570AbSJSJKO>; Sat, 19 Oct 2002 05:10:14 -0400
Received: from postoffice2.mail.cornell.edu ([132.236.56.10]:47761 "EHLO
	postoffice2.mail.cornell.edu") by vger.kernel.org with ESMTP
	id <S265568AbSJSJKN>; Sat, 19 Oct 2002 05:10:13 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5.44 - scripts/kconfig.tk error (xconfig fails)
Date: Sat, 19 Oct 2002 05:17:53 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210190517.53089.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

