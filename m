Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129221AbQKGUu5>; Tue, 7 Nov 2000 15:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129265AbQKGUur>; Tue, 7 Nov 2000 15:50:47 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:60420 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S129221AbQKGUue>; Tue, 7 Nov 2000 15:50:34 -0500
Message-ID: <3A086B18.8B403C3F@holly-springs.nc.us>
Date: Tue, 07 Nov 2000 15:50:32 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: continuing VM madness
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Should kswapd and klogd ever get "do_try_to_free_pages failed"? when
this happens my machine is destabilized, and pauses briefly from time to
time before locking up or otherwise becoming inert. This is 2.2.16+USB.

Nov  7 14:51:36 cartman kernel: VM: do_try_to_free_pages failed for
kswapd... 
Nov  7 15:46:39 cartman kernel: VM: do_try_to_free_pages failed for
panel... 
Nov  7 15:46:39 cartman kernel: VM: do_try_to_free_pages failed for
klogd... 
Nov  7 15:46:40 cartman kernel: VM: do_try_to_free_pages failed for
identd... 
Nov  7 15:46:40 cartman kernel: VM: do_try_to_free_pages failed for
mini_commander_... 
Nov  7 15:46:40 cartman kernel: VM: do_try_to_free_pages failed for
gpm... 
Nov  7 15:46:40 cartman kernel: VM: do_try_to_free_pages failed for
mozilla-bin... 
Nov  7 15:46:40 cartman kernel: VM: do_try_to_free_pages failed for
mozilla-bin... 
Nov  7 15:46:40 cartman kernel: VM: do_try_to_free_pages failed for
init... 
Nov  7 15:46:40 cartman kernel: VM: do_try_to_free_pages failed for
xntpd... 
Nov  7 15:46:40 cartman kernel: VM: do_try_to_free_pages failed for
nmbd... 
Nov  7 15:46:40 cartman kernel: VM: do_try_to_free_pages failed for
vmware... 
Nov  7 15:46:40 cartman kernel: VM: do_try_to_free_pages failed for
vmware...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
