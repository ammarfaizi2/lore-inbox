Return-Path: <linux-kernel-owner+w=401wt.eu-S932908AbWLSTPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932908AbWLSTPj (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 14:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932909AbWLSTPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 14:15:39 -0500
Received: from main.gmane.org ([80.91.229.2]:48117 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932908AbWLSTPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 14:15:38 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: free module selection
Date: Tue, 19 Dec 2006 15:12:40 +0000 (UTC)
Message-ID: <loom.20061219T160528-626@post.gmane.org>
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net> <20061214005532.GA12790@suse.de> <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 62.217.57.165 (Mozilla/5.0 (X11; U; Linux i686; de; rv:1.8.0.3) Gecko/20060425 SUSE/1.5.0.3-7 Firefox/1.5.0.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Btw, I really think this is shortsighted.
> 
> It will only result in _exactly_ the crap we were just trying to avoid, 
> namely stupid "shell game" drivers that don't actually help anything at 
> all, and move code into user space instead.

I would like to contribute some more viewpoints to this hot discussion.

Greg Kroah-Hartman revoked a bit of his code suggestion to take time for second
thoughts on the topic.
http://article.gmane.org/gmane.linux.kernel/475890


> So go get it merged in the Ubuntu, (Open)SuSE and RHEL and Fedora trees 
> first. This is not something where we use my tree as a way to get it to 
> other trees. This is something where the push had better come from the 
> other direction.

I hope that people from such distributions will not create too much pressure to
"standardise" in licence limitations.

I imagine that there is the important matter of free choice and corresponding
fair use. Software techniques can help to choose between available alternatives
and possibilities.

1. How much can (kernel) modules be filtered for specific needs like it is
performed by class loaders for the Java programming languagge?
   Are any interceptors internally involved that might throw exceptions to
forward constraints handling to special signal handlers?
   http://en.wikipedia.org/wiki/Chain-of-responsibility_pattern

2. Greg's design approach seems to be a nice option for testing purposes.
   http://www.kroah.com/log/2006/12/13#uio

   Are there any similarities with microkernels?
   In which "space" would you like to run your device drivers?

3. All interested parties can develop a Linux distribution for the specific
needs of the various users and customers. It may be a fun project as a hobby or
it would be something for production applications like IPCop or SELinux. They
can also distinguish the acceptable licences on their own. How much do they
really want a limited selection that will be enforced by tools for the discussed
use case?
   http://distrowatch.com/

Regards,
Markus

