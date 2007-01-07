Return-Path: <linux-kernel-owner+w=401wt.eu-S932565AbXAGO6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbXAGO6h (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 09:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbXAGO6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 09:58:37 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:43249 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932563AbXAGO6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 09:58:36 -0500
Date: Sun, 7 Jan 2007 14:57:30 +0000
From: Robert Fitzsimons <robfitz@273k.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: git@vger.kernel.org, nigel@nigel.suspend2.net,
       "J.H." <warthog9@kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org
Subject: Re: How git affects kernel.org performance
Message-ID: <20070107145730.GB24706@localhost>
References: <20061214223718.GA3816@elf.ucw.cz> <20061216094421.416a271e.randy.dunlap@oracle.com> <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain> <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A083F2.5000000@zytor.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-0.012, required 7,
	autolearn=disabled, RCVD_IN_NERDS_IE -2.00, RCVD_IN_SORBS_DUL 1.99)
X-MailScanner-From: robfitz@273k.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some more data on how git affects kernel.org...

I have a quick question about the gitweb configuration, does the
$projects_list config entry point to a directory or a file?

When it is a directory gitweb ends up doing the equivalent of a 'find
$project_list' to find all the available projects, so it really should
be changed to a projects list file.

Robert

