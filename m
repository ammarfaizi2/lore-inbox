Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265381AbRGBSL2>; Mon, 2 Jul 2001 14:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265382AbRGBSLS>; Mon, 2 Jul 2001 14:11:18 -0400
Received: from wrath.cs.utah.edu ([155.99.198.100]:22450 "EHLO
	wrath.cs.utah.edu") by vger.kernel.org with ESMTP
	id <S265381AbRGBSLE>; Mon, 2 Jul 2001 14:11:04 -0400
Date: Mon, 2 Jul 2001 12:11:02 -0600 (MDT)
From: Shashi Guruprasad <shash@cs.utah.edu>
To: linux-kernel@vger.kernel.org
Subject: cleaning up a socket in FIN_WAIT_1 
Message-ID: <Pine.LNX.4.21.0107021204210.8956-100000@famine.cs.utah.edu>
Return-Recipt-To: <shash@cs.utah.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A socket got stuck in the FIN_WAIT_1 state coz the client that was
generating these TCP segments got terminated prematurely. The kernel does
clean it up after 2MSL seconds. However, I would like to know if there is
a way to explicitly clean it up from the command line (as root).  
SO_REUSEADDR option only helps for sockets in TIME_WAIT. Also, Does the
kernel have such mechanisms to clean up any kernel data structure?

I would appreciate it if whoever answers this query also Cc me coz I'm not
subscribed to the kernel mailing list.

Thanks,
Shashi

