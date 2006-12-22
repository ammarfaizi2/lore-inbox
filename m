Return-Path: <linux-kernel-owner+w=401wt.eu-S1751632AbWLVXVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbWLVXVT (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 18:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753231AbWLVXVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 18:21:19 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:32807 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751632AbWLVXVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 18:21:18 -0500
Date: Sat, 23 Dec 2006 00:19:25 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Rewrite unnecessary duplicated code to use
 FIELD_SIZEOF().
In-Reply-To: <Pine.LNX.4.64.0612220942140.2047@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0612230017000.16006@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0612170738410.24046@localhost.localdomain>
 <20061220164651.4ee2e960.akpm@osdl.org> <20061222140550.GB26033@infradead.org>
 <Pine.LNX.4.64.0612220942140.2047@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 22 2006 09:43, Robert P. J. Day wrote:
>
>that's the name as it *already* existed in kernel.h.  however, since
>no one was actually using it yet, it's a piece of cake to give it a
>better name.  either FIELD_SIZE or MEMBER_SIZE would work just fine.

I 'd go for MEMBER_SIZE. (Compare the proportion of literature that uses
'struct members' and 'struct fields'. On another note,
Regular ("agricultural/geometrical") meaning: Feld (ger.) <-> field
informatics: Feld <-> array)


	-`J'
-- 
