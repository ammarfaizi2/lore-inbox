Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318006AbSFSVHi>; Wed, 19 Jun 2002 17:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318011AbSFSVHh>; Wed, 19 Jun 2002 17:07:37 -0400
Received: from mail.science.uva.nl ([146.50.4.51]:41452 "EHLO
	mail.science.uva.nl") by vger.kernel.org with ESMTP
	id <S318006AbSFSVHf>; Wed, 19 Jun 2002 17:07:35 -0400
Message-Id: <200206192105.g5JL5u808895@mail.science.uva.nl>
X-Organisation: Faculty of Science, University of Amsterdam, The Netherlands
X-URL: http://www.science.uva.nl/
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rvandijk@science.uva.nl>
Reply-To: rvandijk@science.uva.nl
Organization: UvA
To: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.23-dj2
Date: Wed, 19 Jun 2002 23:08:58 +0200
X-Mailer: KMail [version 1.3.2]
References: <20020619205136.GA18903@suse.de>
In-Reply-To: <20020619205136.GA18903@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 June 2002 22:51, Dave Jones wrote:
> Lots of bits got thrown out this time, as Christoph Hellwig went through
> the patch and picked up on quite a few obviously wrong bits. In addition,
> this patch introduces the mad axemen, who come to carve up all that is
> monolithic. Patrick's MTRR split-up has been around for a while, and could
> use a bit more testing before it goes to Linus. The AGPGART changes I did
> this afternoon, and haven't seen much testing at all yet.
>
> Finally, another round of compile fixes and the likes from Linux Kernel.
>

got this error with make xconfig (which worked in -dj1):

make[1]: Entering directory `/usr/src/kernel/linux-2.5.23-dj2/scripts'
  Generating kconfig.tk
-: 172: incorrect argument
chmod 755 kconfig.tk
make[1]: Leaving directory `/usr/src/kernel/linux-2.5.23-dj2/scripts'
wish -f scripts/kconfig.tk
Error in startup script: invalid command name "clear_choices"
    while executing
"clear_choices"
    (procedure "read_config" line 3)
    invoked from within
"read_config .config"
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

	Rudmer
