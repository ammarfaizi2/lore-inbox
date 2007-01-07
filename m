Return-Path: <linux-kernel-owner+w=401wt.eu-S965214AbXAGVb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965214AbXAGVb7 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 16:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbXAGVb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 16:31:59 -0500
Received: from terminus.zytor.com ([192.83.249.54]:46897 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965196AbXAGVb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 16:31:58 -0500
Message-ID: <45A1668D.2010203@zytor.com>
Date: Sun, 07 Jan 2007 13:30:53 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Jeff Garzik <jeff@garzik.org>, nigel@nigel.suspend2.net,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       "J.H." <warthog9@kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       webmaster@kernel.org, Git Mailing List <git@vger.kernel.org>
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
References: <20061214223718.GA3816@elf.ucw.cz> <20061216094421.416a271e.randy.dunlap@oracle.com> <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain> <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net> <45A07587.3080503@garzik.org> <20070107201146.GA21956@suse.de>
In-Reply-To: <20070107201146.GA21956@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> 
> Well, I create my repos by doing a:
> 	git clone -l --bare
> which makes a hardlink from Linus's tree.
> 
> But then it gets copied over to the public server, which probably severs
> that hardlink :(
> 
> Any shortcut to clone or set up a repo using "alternatives" so that we
> don't have this issue at all?
> 

Use the -s option to git clone.

	-hpa
