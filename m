Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTFOMyN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 08:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbTFOMyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 08:54:13 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:18191 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262192AbTFOMyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 08:54:12 -0400
Date: Sun, 15 Jun 2003 14:07:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: torvalds@transmeta.com
Cc: mochel@osdl.org, david-b@pacbell.net, linux-kernel@vger.kernel.org
Subject: GFDL in the kernel tree
Message-ID: <20030615140758.A9390@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	torvalds@transmeta.com, mochel@osdl.org, david-b@pacbell.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.71 introduces two GFDL-licensed files in the kernel tree, there's
a few problems with this, because:

(1) COPYING in the toplevel says the kernel tree is GPLv2, GFDL is
    GPL incompatible.
(2) Documentation/DocBook/gadget.tmpl, one of the files, includes
    extracted from source files licensed under GPL, making this
    a GPL license violation.
(3) Documentation/kobject.txt, the other files claims it's under
    GFDL but doesn't actually include the license text as mandated
    by the GFDL.

And of course there's still all those nasty issue with GFDL like
invariant sections and cover texts that make at least the debian-devel
list believe it's an unfree license..

Folks, could we please only use GPL-compatible licenses in the kernel
tree?
