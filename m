Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262797AbVGKVmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbVGKVmZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 17:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262773AbVGKVkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 17:40:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3761 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262788AbVGKVjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 17:39:13 -0400
Date: Mon, 11 Jul 2005 14:40:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jason Baron <jbaron@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pty_chars_in_buffer oops fix
Message-Id: <20050711144001.3bc1c320.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0507111426240.5005@dhcp83-105.boston.redhat.com>
References: <Pine.LNX.4.61.0507111426240.5005@dhcp83-105.boston.redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Baron <jbaron@redhat.com> wrote:
>
> This is a re-posting of a fix for a race condition between changing the 
> line discipline on a pty and and a poll on the 'other' side. The reference 
> is: http://marc.theaimsgroup.com/?l=linux-kernel&m=111342171410005&w=2. 
> Below is a diff against the current tree.

Please (always) send a description of the bug which this patch addresses,
and a description of how it fixes that bug.
