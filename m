Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265682AbTFSOl4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 10:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265766AbTFSOl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 10:41:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59822 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265682AbTFSOlz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 10:41:55 -0400
Date: Thu, 19 Jun 2003 15:55:54 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: David Howells <dhowells@warthog.cambridge.redhat.com>
Cc: David Howells <dhowells@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] VFS autmounter support v2
Message-ID: <20030619145554.GF6754@parcelfarce.linux.theplanet.co.uk>
References: <20030618205945.GD6754@parcelfarce.linux.theplanet.co.uk> <3283.1056016010@warthog.warthog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3283.1056016010@warthog.warthog>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 19, 2003 at 10:46:50AM +0100, David Howells wrote:
 
> Besides, going back to your original argument, I think you make an invalid
> assertion:
> 
> 	Namespaces are completely unrelated - I have them set for two
> 	different users that happen to need some common files, but otherwise
> 	have very different environments.
> 
> They are not quite completely unrelated. The only way (or so it seems) to get
> a new namespace is to derive one by way of CLONE_NS. This clones the namespace
> of the parent, and so the child's namespace then should have all the features
> of the parent's namespace _UNTIL_ at such time the child or one of its
> descendents rearranges the topology!

And how the fuck do you "rearrange topology" with your patch?!?
