Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265306AbUF2Aiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265306AbUF2Aiq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 20:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265311AbUF2Aiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 20:38:46 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:16536 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265306AbUF2Aip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 20:38:45 -0400
Date: Tue, 29 Jun 2004 01:37:23 +0100
From: Dave Jones <davej@redhat.com>
To: FabF <fabian.frederick@skynet.be>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.7-mm3] cpuflags reviewed
Message-ID: <20040629003723.GA30230@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	FabF <fabian.frederick@skynet.be>, Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1088416506.2395.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088416506.2395.9.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 11:55:06AM +0200, FabF wrote:
 > Andrew,
 > 
 > 	Here's cpuflags v2 (x86 version) :
 > 
 > [/proc/cpuflags snippet]
 > no  sse2
 > no  ss
 > no  ht
 > no  tm
 > no  ia64
 > no  pbe
 > yes syscall
 > yes mp
 > no  nx
 > yes mmxext
 > no  lm
 > yes 3dnowext

This can be done just as easily (if not easier) in userspace.
I see no value in adding a duplicate flag mechanism to the kernel.

		Dave

