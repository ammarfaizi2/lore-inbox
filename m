Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289015AbSBSACO>; Mon, 18 Feb 2002 19:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289018AbSBSACE>; Mon, 18 Feb 2002 19:02:04 -0500
Received: from rgminet1.oracle.com ([148.87.122.30]:7413 "EHLO
	rgminet1.oracle.com") by vger.kernel.org with ESMTP
	id <S289017AbSBSABu>; Mon, 18 Feb 2002 19:01:50 -0500
Message-ID: <3C719641.3040604@oracle.com>
Date: Tue, 19 Feb 2002 01:03:13 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020212
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: gnome-terminal acts funny in recent 2.5 series
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running Ximian-latest for rh72/i386, latest 2.5 kernels (including
  2.5.4-pre2, 2.5.4, 2.5.5-pre1).

Symptom:
   - clicking on the panel icon for gnome-terminal shows a flicker
      of the terminal window coming up then the window disappears.
     No leftover processes.

What works 100%:
   - regular xterm in 2.5.x
   - gnome-terminal in 2.4.x (x in .17, .18-pre9, .18-rc2)

More info:
   - doesn't happen 100% of the time, but close
   - trying to start gnome-terminal either vanilla or with the
      parameters in the icon from an xterm causes
       * gnome-terminal window comes up, but no shell prompt; the
          window *does not* disappear and program is in a CPU loop
       * program detaches from calling xterm even when '&' is
          not used
       * calling xterm's tty is left in a funny state (sometimes
          stty sane^J is required, sometimes tput reset)

Any ideas would be quite welcome - I can go back and try and narrow
  down what kernel breaks gnome-terminal if nothing comes up.


Thanks,

--alessandro

  "If your heart is a flame burning brightly
    you'll have light and you'll never be cold
   And soon you will know that you just grow / You're not growing old"
                               (Husker Du, "Flexible Flyer")

