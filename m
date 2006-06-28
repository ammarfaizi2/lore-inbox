Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423347AbWF1OQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423347AbWF1OQo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423343AbWF1OQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:16:40 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:4770 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030507AbWF1OQh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:16:37 -0400
Date: Wed, 28 Jun 2006 09:15:39 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, Sam Vilain <sam@vilain.net>,
       Andrey Savochkin <saw@swsoft.com>, dlezcano@fr.ibm.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
       herbert@13thfloor.at, devel@openvz.org, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>, Mark Huang <mlhuang@CS.Princeton.EDU>
Subject: Re: Network namespaces a path to mergable code.
Message-ID: <20060628141539.GA32736@sergelap.austin.ibm.com>
References: <20060626134945.A28942@castle.nmd.msu.ru> <m14py6ldlj.fsf@ebiederm.dsl.xmission.com> <20060627215859.A20679@castle.nmd.msu.ru> <44A1AF37.3070100@vilain.net> <m1ac7xkifn.fsf@ebiederm.dsl.xmission.com> <44A21F7A.5030807@vilain.net> <m1r719ixb6.fsf@ebiederm.dsl.xmission.com> <44A251F2.70707@fr.ibm.com> <m1bqsdidhe.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1bqsdidhe.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> > I think we're reaching the limits of namespaces. It would be much easier
> > with a container id in each kernel object we want to isolate.
> 
> Nope.  Except for the fact that names are peculiar (sockets, network
> device names, IP address, routes...) the network stack splits quite cleanly.
> 
> I did all of this in a proof of concept mode several months ago and
> the code is still sitting in my git tree on kernel.org.  I even got
> the generic stack reference counting fixed.
> 
> Eric

Which branch?
