Return-Path: <linux-kernel-owner+w=401wt.eu-S964875AbXAGTO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbXAGTO3 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 14:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbXAGTO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 14:14:28 -0500
Received: from shards.monkeyblade.net ([192.83.249.58]:45542 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964875AbXAGTO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 14:14:27 -0500
Subject: Re: How git affects kernel.org performance
From: "J.H." <warthog9@kernel.org>
To: Robert Fitzsimons <robfitz@273k.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
       nigel@nigel.suspend2.net, Randy Dunlap <randy.dunlap@oracle.com>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org
In-Reply-To: <20070107145730.GB24706@localhost>
References: <20061214223718.GA3816@elf.ucw.cz>
	 <20061216094421.416a271e.randy.dunlap@oracle.com>
	 <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com>
	 <1166297434.26330.34.camel@localhost.localdomain>
	 <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com>
	 <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com>
	 <45A083F2.5000000@zytor.com>  <20070107145730.GB24706@localhost>
Content-Type: text/plain
Date: Sun, 07 Jan 2007 11:12:25 -0800
Message-Id: <1168197145.14963.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With my gitweb caching changes this isn't as big of a deal as the front
page is only generated once every 10 minutes or so (and with the changes
I'm working on today that timeout will be variable)

- John

On Sun, 2007-01-07 at 14:57 +0000, Robert Fitzsimons wrote:
> > Some more data on how git affects kernel.org...
> 
> I have a quick question about the gitweb configuration, does the
> $projects_list config entry point to a directory or a file?
> 
> When it is a directory gitweb ends up doing the equivalent of a 'find
> $project_list' to find all the available projects, so it really should
> be changed to a projects list file.
> 
> Robert

