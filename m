Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266354AbTABTAP>; Thu, 2 Jan 2003 14:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266359AbTABTAP>; Thu, 2 Jan 2003 14:00:15 -0500
Received: from dclient217-162-80-86.hispeed.ch ([217.162.80.86]:28548 "EHLO
	gamecube.hb9jnx.ampr.org") by vger.kernel.org with ESMTP
	id <S266354AbTABTAO>; Thu, 2 Jan 2003 14:00:14 -0500
Subject: Re: [PATCH] Deprecate exec_usermodehelper, fix request_module.
From: Thomas Sailer <sailer@scs.ch>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       akpm@zip.com.au, Jose Orlando Pereira <jop@di.uminho.pt>,
       J.E.J.Bottomley@HansenPartnership.com
In-Reply-To: <1041527666.16046.18.camel@pegasus.local>
References: <20030102093637.8C6892C2FB@lists.samba.org> 
	<1041527666.16046.18.camel@pegasus.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 02 Jan 2003 20:08:28 +0100
Message-Id: <1041534508.2074.32.camel@gamecube>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-02 at 18:14, Marcel Holtmann wrote:

> for the bt3c_cs driver I need to run a user space program that downloads
> the firmware into the card and the kernel part have to wait until this
> program has finished. So what is the best way to do this now?

We all seem to have the same problem 8-)

Rusty's new proposal with the wait argument seems to solve our problem,
except that it would be nice if there was a way to retrieve the exit
status of the user mode helper program.

Tom

