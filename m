Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262461AbVC3W3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbVC3W3K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 17:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVC3W3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 17:29:10 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:53653 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262461AbVC3W3E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 17:29:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=MRgpK2FSdQdp7xu5/g8UdSkiyaE2M6D/ONkig2F3iXz82OWsYS+mfk8p2luXSS1ijPfx6FPvcjj8mAwTTHSvNz0ZqpEbxFWxd1gS+r/Q9DWDy0yLtkWtHh5WqxmBzaSxpqVMLteXSy2ofxEDrKZ3nfZ9s2a6V6tIaOXrKwrJTbw=
Date: Thu, 31 Mar 2005 00:29:00 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: pj@engr.sgi.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [patch 0/8] CKRM: Core patch set
Message-Id: <20050331002900.5c5dd04a.diegocg@gmail.com>
In-Reply-To: <E1DGkl7-0002aV-00@w-gerrit.beaverton.ibm.com>
References: <20050330225505.7a443227.diegocg@gmail.com>
	<E1DGkl7-0002aV-00@w-gerrit.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.9.7+svn (GTK+ 2.6.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 30 Mar 2005 13:29:53 -0800,
Gerrit Huizenga <gh@us.ibm.com> escribió:

> been under so much revision lately.  However, resource utilization at the
> priority level does not allow you to say "OpenOffice can have up to 30%
> of my CPU, my email client is guaranteed to get at least 5%, and Firefox +
> Java apps get no more than 50% of my machine, and my CD player gets 10%".
> Niceness levels provide none of that level of resource control.  Also,

Users can launch tasks and renice them to lowest priority levels..., with the highset
priority being given by the administrator...I've always though it's gnome/kde fault to launch
the apps at the same nice level than the panel and the window manager. Despite of 
that my "design" wouldn't achieve that such fine-grained control, no - I'd argue that not
many people needs that, but then I shouldn't tell people what they need (and anyway
the previous proposal would so powerful for its simplicity that it might be worth of it doing
it anyway)

>  I'd love to see patches which could be validated by folks like the PlanetLab
>  folks, for instance.  I don't believe it is possible to get the level of machine
>  partitioning/virtualization that CKRM provides with this overly simple prioritization
>  scheme.

I realize that CKRM provides much broader functionality, the alternative I was proposing
was just for CPU resources (and would probably work well for IO bandwith with CFQ),
I realize that things like "partitioning memory resources" is a whole different problem.

But I certainly think that CKRM is far too complex - the docs I've read spent all the time
describing things like classes, classes inhretance, classification engine, resources
scheduler, resource schedulers configuration and so on. I must admit I've not read too
much about CKRM - I had to stop because I couldn't understand it, everything is far too
complex to my little mind, and I'm saying this because I bet I'm not the only one here
who can't understand it either.....
