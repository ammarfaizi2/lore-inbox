Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264303AbTLYNJv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 08:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbTLYNJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 08:09:51 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2944 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264303AbTLYNJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 08:09:50 -0500
Date: Thu, 25 Dec 2003 13:16:07 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200312251316.hBPDG7LT000163@81-2-122-30.bradfords.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>,
       David Monro <davidm@amberdata.demon.co.uk>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
In-Reply-To: <20031225063936.GA15560@win.tue.nl>
References: <3FEA5044.5090106@amberdata.demon.co.uk>
 <20031225063936.GA15560@win.tue.nl>
Subject: Re: handling an oddball PS/2 keyboard
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suppose Vojtech will have no objections to using this ID
> to skip the tests for e0 and e1 as protocol (escape) scancodes.

There might be no need for such a workaround - a lot of PS/2 devices
which were not intended for PCs work fine in set 3, particularly if
the device they were intended to work with uses set 3 natively, where
this conflict with protocol scancodes problem doesn't exist.  If the
keyboard works in set 3, add 0xab85 to the list of keyboards to force
set 3 for, (and maybe also add the ID for my keyboard while we're at
it :-) ).

John.
