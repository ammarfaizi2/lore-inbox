Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVFZLhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVFZLhp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 07:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVFZLho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 07:37:44 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:51376 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261240AbVFZLhl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 07:37:41 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12 initrd module loading seems parallel on bootup
Date: Sun, 26 Jun 2005 09:19:41 -0400
User-Agent: KMail/1.8.1
Cc: "Darryl L. Miles" <darryl@netbauds.net>, linux-kernel@vger.kernel.org,
       Christian Trefzer <ctrefzer@web.de>,
       Martin Wilck <martin.wilck@fujitsu-siemens.com>
References: <42BDFEC2.3030004@netbauds.net> <20050625234611.118b391d.akpm@osdl.org>
In-Reply-To: <20050625234611.118b391d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506260919.41982.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 June 2005 02:46, Andrew Morton wrote:
> I'd like to know what changed in the kernel to make nash's behaviour
> change.  Martin, did you work that out?
Quoting from Prarit Bhargava's email (http://lkml.org/lkml/2005/6/14/149)
-
"The issue is that David Howells posted a patch that changed the behaviour of 
kallsyms/insmod/rmmod sometime ago.  The patch *is correct* in what it does, 
however, the patch requires that /sbin/sh must be aware of pid returns by 
wait() - http://lkml.org/lkml/2005/1/17/132"

IIRC this issue was same as the one faced by Martin.

Parag
