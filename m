Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVANRDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVANRDy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 12:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVANRDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 12:03:39 -0500
Received: from pool-151-203-218-166.bos.east.verizon.net ([151.203.218.166]:6148
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262027AbVANRCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 12:02:19 -0500
Message-Id: <200501141924.j0EJONnV003234@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: blaisorblade_spam@yahoo.it
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 04/11] uml: refuse to run without skas if no tt mode in 
In-Reply-To: Your message of "Thu, 13 Jan 2005 22:00:56 +0100."
             <20050113210056.465BEBAB5@zion> 
References: <20050113210056.465BEBAB5@zion> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 14 Jan 2005 14:24:23 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it my imagination, or did you put the definition of can_do_skas under 
#ifdef UML_CONFIG_MODE_SKAS and failed to do the same for the call?

				Jeff

