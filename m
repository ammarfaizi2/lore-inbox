Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262493AbVGMTdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbVGMTdo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbVGMSte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:49:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65159 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262340AbVGMSsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:48:23 -0400
Message-ID: <42D561AB.3060002@redhat.com>
Date: Wed, 13 Jul 2005 14:47:07 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: "Vlad C." <vladc6@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux On-Demand Network Access (LODNA)
References: <20050712234425.55899.qmail@web54409.mail.yahoo.com> <42D5340A.7060002@redhat.com> <42D55C75.4010307@namesys.com>
In-Reply-To: <42D55C75.4010307@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

>Peter, do you agree with his point that mounting should be something
>ordinary users can do on mountpoints they have write permission for?
>
>Do you agree that a systematic review of user friendliness would help
>NFS?  Do you think that NFS should look at SFS and consider adopting
>some of its features?
>

I think that connecting to required data could be more easily done than
currently. I don't know about allowing file systems to be mounted without
some form of control or resource utilization controls however.

I do agree that the entire user experience associated with using and trying
to administrate an NFS network could stand a good, long, hard look.

Traditional tools such as the automounter were nice 15 years ago, but have
not evolved with the world, nor have the rest of the system tools for
monitoring and managing NFS clients and servers.

I could definitely envision better ways to handle things.  In the past,
many of the arguments against making things better were security related.
There has been strong (relative term) security available to NFS 
implementations
since 1997, but many vendors have not implemented it and many customers 
found
it difficult to deploy because the underlying tools were very difficult to
deploy.  Many of the vendors are now implementing the security 
framework, but
more work is required on the underlying security mechanisms, making them
easier to deploy.

With proper security, usable monitoring and management tools, and flexible
resource controls, then I wouldn't see why NFS mounts should be anything
special.

    Thanx...

       ps
