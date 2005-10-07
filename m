Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030476AbVJGQQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030476AbVJGQQF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 12:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbVJGQQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 12:16:05 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:49826 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030476AbVJGQQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 12:16:03 -0400
Date: Fri, 7 Oct 2005 12:15:58 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: Dell firmware default config options?
In-Reply-To: <43469A9A.2070104@beezmo.com>
Message-ID: <Pine.LNX.4.58.0510071209140.8299@localhost.localdomain>
References: <43469A9A.2070104@beezmo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm just curious why the Dell firmware configuration options are default
to "m" instead of "n".  Since it only matters if you have a Dell System.

So for the huge number of systems that are not Dell Systems, they are
probably wasting CPU cycles compiling these as modules, and taking up
space in loads of /lib/modules directories throughout the world ;-)

DCDBAS explicitly states default of "m", and DELL_RBU has no default which
just makes it automatically on.

Is there any reason that these shouldn't be turned off by default?

Thanks,

-- Steve


