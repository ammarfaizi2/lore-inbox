Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319159AbSHMXNS>; Tue, 13 Aug 2002 19:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319174AbSHMXMj>; Tue, 13 Aug 2002 19:12:39 -0400
Received: from u212-239-155-52.freedom.planetinternet.be ([212.239.155.52]:2820
	"EHLO jebril.pi.be") by vger.kernel.org with ESMTP
	id <S319159AbSHMXKC>; Tue, 13 Aug 2002 19:10:02 -0400
Message-Id: <200208132312.g7DNCP5R002438@jebril.pi.be>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: John Weber <john.weber@linux.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.31 and fd 3 
In-Reply-To: Your message of "Sun, 11 Aug 2002 21:36:37 EDT."
             <3D571125.9050203@linux.org> 
Date: Wed, 14 Aug 2002 01:12:25 +0200
From: "Michel Eyckmans (MCE)" <mce@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I am completely mistified by this problem, but after loading kernel 
> 2.5.31 I am unable to open an xterm in X windows.  The system complains 
> about being unable to stat fd 3.

I ran into the same problem while trying to figure out my module
loading problems with 2.5.31. Turns out that disabling CONFIG_PREEMPT 
to get modules working also fixes the xterm failure.

MCE
