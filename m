Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268370AbTGLTYK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 15:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268376AbTGLTYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 15:24:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17036 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268370AbTGLTYJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 15:24:09 -0400
Message-ID: <3F1063AD.40206@pobox.com>
Date: Sat, 12 Jul 2003 15:38:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Andrew Morton <akpm@osdl.org>, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5 'what to expect'
References: <20030711140219.GB16433@suse.de> <20030712152406.GA9521@mail.jlokier.co.uk> <3F103018.6020008@pobox.com> <20030712112722.55f80b60.akpm@osdl.org> <20030712183929.GA10450@mail.jlokier.co.uk> <3F105B9A.7070803@pobox.com> <20030712193401.GD10450@mail.jlokier.co.uk>
In-Reply-To: <20030712193401.GD10450@mail.jlokier.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 2.4 fails on write()?  A strace of "rpm --rebuilddb" shows it is
> opening with O_DIRECT and writing just fine.  Or does that only work
> with RedHat's 2.4 kernels?


Are you testing on a filesystem where an O_DIRECT is not supported?

The "it works" case is not an issue.

	Jeff



