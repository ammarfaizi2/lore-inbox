Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267323AbTGMHJn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 03:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270138AbTGMHJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 03:09:42 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:40608 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S267323AbTGMHJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 03:09:41 -0400
Date: Sun, 13 Jul 2003 09:24:02 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "Nathaniel W. Filardo" <nwf@andrew.cmu.edu>
Cc: Martin Sarsale <lists@runa.sytes.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.75 everything looks ok!
Message-ID: <20030713072402.GA3415@louise.pinerecords.com>
References: <20030712155400.4247908f.lists@runa.sytes.net> <Pine.LNX.4.55L-032.0307121735260.8182@unix47.andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L-032.0307121735260.8182@unix47.andrew.cmu.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [nwf@andrew.cmu.edu]
> 
> If this is your first time running 2.5, that makes sense.  The
> modules_install would have taken place running under a 2.4 kernel so
> depmod would have called the modutils (2.4) depmod and not generated the
> appropriate files.  Calling "depmod -ae" when running under 2.5 should
> generate these (stored in /lib/modules/2.5.75/) and allow modprobe to work
> again.

With module-init-tools properly installed,

	depmod -a -F /path/to/System.map-2.5.x 2.5.x

should work correctly regardless of the version of the running kernel.

-- 
Tomas Szepe <szepe@pinerecords.com>
