Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266048AbUIOOt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUIOOt7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 10:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUIOOt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 10:49:59 -0400
Received: from smtp3.adl2.internode.on.net ([203.16.214.203]:45317 "EHLO
	smtp3.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S266048AbUIOOt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 10:49:57 -0400
Date: Thu, 16 Sep 2004 00:40:42 +1000
From: callipygous@internode.on.net
To: linux-kernel@vger.kernel.org
Subject: bug: terminal freezes
Message-ID: <20040915144042.GA17054@burrito>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I probably used the 2.6.8 kernel for about a week before going back to 2.6.7  due to a bug which
makes the keyboard loose input.  I'm not exactly sure what causes this, but have found it to happen
when I ^z a process and then attempt to fg it again.  What happens is I cannot do anything, the 
process doesn't come back into the foreground properly, and i loose the keyboard.  
I thought it must have been a crash, but no, I could still ssh into the machine, which I did, and
killed the process that didn't foreground properly, which I noticed changed the screen on the 
offending box back to another psuedo terminal session which was running irssi, and the screen
was still scrolling text as people chatted.  So I tried then, since im using a USB keyboard, 
restarting hotplug, after doing that, I was able to use the keyboard again.

Hope this helps anyway, any other questions don't hesitate to ask.
Thanks

Mark
-- 
          POWERED BY                                      #####
                                                         #######
                 @                                       ##O#O##
######        @@#                                        #VVVVV#
  ##           #                                       ##  VVV  ##
  ##       @@@   ### ####   ###    ###  ##### ######  #          ##
  ##      @  @#   ###    ##  ##     ##    ###  ##    #            ##
  ##     @   @#   ##     ##  ##     ##      ###      #            ###
  ##        @@#   ##     ##  ##     ##      ###     QQ#           ##Q
  ##     # @@#    ##     ##  ##     ##     ## ##  QQQQQQ#       #QQQQQQ
  ##    ## @@# #  ##     ##  ###   ###    ##   ## QQQQQQQ#     #QQQQQQQ
##########  ###  ####   ####   #### ### ##### ##### QQQQQ#######QQQQQ
