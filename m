Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265292AbSJXCbW>; Wed, 23 Oct 2002 22:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265293AbSJXCbW>; Wed, 23 Oct 2002 22:31:22 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:55690 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S265292AbSJXCbV>; Wed, 23 Oct 2002 22:31:21 -0400
Date: Wed, 23 Oct 2002 22:37:29 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.44-ac2 Make xconfig fails
Message-ID: <20021024023729.GA7800@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[grimau@Master linux-2.5.44-ac2]$ make xconfig
make -f scripts/Makefile scripts/kconfig.tk
...(bunch of gcc lines)
  Generating scripts/kconfig.tk
-: 73: unknown command
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
[grimau@Master linux-2.5.44-ac2]$

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

