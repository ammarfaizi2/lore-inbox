Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262685AbVAVJxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbVAVJxb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 04:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVAVJxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 04:53:31 -0500
Received: from main.gmane.org ([80.91.229.2]:15597 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262685AbVAVJx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 04:53:26 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: How to examine physical address content in Linux
Date: Sat, 22 Jan 2005 10:53:21 +0100
Message-ID: <yw1xpszxpz72.fsf@ford.inprovide.com>
References: <007b01c50064$f9c64f60$f447728c@linux8l5god6us>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:6WIIY0mkg6FhSqsuCQuoDWWVVTk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kai-Yuan Ho" <mr934318@cs.nthu.edu.tw> writes:

> Dear all:
> As I know , the address we can see are virtual address.
> How can I examine physical address content in Linux?

If you want to look at a specific physical address, you can read (or
mmap) /dev/mem, if you are root.  Be careful though, even reading
certain addresses will crash your computer.

If you want the virtual to physical mapping for your process, there is
no simple way.

-- 
Måns Rullgård
mru@inprovide.com

