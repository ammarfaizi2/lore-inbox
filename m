Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVEISop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVEISop (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 14:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVEISop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 14:44:45 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:6768 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261483AbVEISom convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 14:44:42 -0400
From: Kristian =?iso-8859-1?q?S=F8rensen?= <ks@cs.aau.dk>
Organization: Linnovative
To: Chris Friesen <cfriesen@nortel.com>
Subject: Re: Any work in implementing Secure IPC for Linux?
Date: Mon, 9 May 2005 20:44:29 +0200
User-Agent: KMail/1.8
Cc: James Morris <jmorris@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Xine.LNX.4.44.0505091058560.5582-100000@thoron.boston.redhat.com> <200505091940.22260.ks@linnovative.dk> <427FA3D4.1080706@nortel.com>
In-Reply-To: <427FA3D4.1080706@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200505092044.29440.ks@cs.aau.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 May 2005 19:54, Chris Friesen wrote:
> Kristian Sørensen wrote:
> >  By "secure IPC" is meaning a
> > security mechanism that provides a more fine granularity of specifying
> > who are allowed to send (or receive) messages... and maby also a way to
> > resolve the question of "Can I trust the message I received?"
>
> How about unix sockets?
> 	--you can have sockets in the filesystem namespace with regular file
> permissions to control who is allowed to send messages to particular
> addresses
This is the same problem: Basing access control on user and group is not 
enough - especially as the root-user can overrule any access control 
specified by the normal DAC file attributes.

> 	--you can authenticate who is sending the message using SCM_CREDENTIALS
I guess this poses the same problem as above?


KS


-- 
Kristian Sørensen
  The Umbrella Project  --  Security for Consumer Electronics
  Linnovative  --  www.linnovative.dk
  ks@linnovative.dk  --  +45 2972 3816
