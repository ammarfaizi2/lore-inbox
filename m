Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWIKEPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWIKEPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 00:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWIKEPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 00:15:18 -0400
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:63625 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750877AbWIKEPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 00:15:17 -0400
Date: Mon, 11 Sep 2006 00:12:52 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: 2.6.18-rc: EMBEDDED menu is split up
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>
Message-ID: <200609110014_MC3-1-CAD2-A49D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In menuconfig, I enabled CONFIG_EMBEDDED in the "general setup" menu
and all of the submenu items starting with "enable futex support" appeared
in the main menu instead of the submenu:

         [*] Configure standard kernel features (for small systems)  --->                
         [*] Enable futex support (NEW)                                                  
         [*] Enable eventpoll support (NEW)                                              
         [*] Use full shmem filesystem (NEW)                                      
         [*] Use full SLAB allocator (NEW)                                          
         [*] Enable VM event counters for /proc/vmstat (NEW)                      

Two more items also appear, but they're _above_ the submenu prompt:

         [*] Sysctl support (NEW)                                                        

         [*] Enable 16-bit UID system calls (NEW)                                        

Should these be moved into the submenu?

-- 
Chuck

