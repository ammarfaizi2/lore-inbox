Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265505AbTGLMy4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 08:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265564AbTGLMy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 08:54:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37248 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265505AbTGLMyz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 08:54:55 -0400
Date: Sat, 12 Jul 2003 14:09:25 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.75: Oops with ax25
Message-ID: <20030712130925.GA636@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.5.75 (i686)
X-Uptime: 14:05:47 up 5 min,  1 user,  load average: 0.15, 0.17, 0.09
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  with ax25 compiled in 2.5.75 oops's at:

  sk_free
  ax25_release
  sock_close
  sock_release
  sock_close
  sock_close
  __fput
  filp_close
  ?
  do_exit
  do_groupexit
  syscall_call

  from ifconfig

(Copied down by hand)

(Other than that it seems fine; dual athlon MP, built on Debian/sid
so I think its using gcc 3.3.1)

Dave
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
