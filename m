Return-Path: <linux-kernel-owner+w=401wt.eu-S932690AbWLZQPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbWLZQPG (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 11:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbWLZQPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 11:15:06 -0500
Received: from terminus.zytor.com ([192.83.249.54]:35754 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932690AbWLZQPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 11:15:04 -0500
Message-ID: <45914A52.6000002@zytor.com>
Date: Tue, 26 Dec 2006 08:14:10 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, "J.H." <warthog9@kernel.org>,
       Willy Tarreau <w@1wt.eu>, Matti Aarnio <matti.aarnio@zmailer.org>,
       Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       hpa@zytor.com, webmaster@kernel.org
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
References: <20061214223718.GA3816@elf.ucw.cz> <20061216094421.416a271e.randy.dunlap@oracle.com> <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain> <45858B3A.5050804@oracle.com> <20061217223730.GW10054@mea-ext.zmailer.org> <1166402576.26330.81.camel@localhost.localdomain> <20061219064646.GJ24090@1wt.eu> <1166513991.26330.136.camel@localhost.localdomain> <20061219143606.GE25461@redhat.com>
In-Reply-To: <20061219143606.GE25461@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> A wild idea just occured to me.  You guys are running Fedora/RHEL kernels
> on the kernel.org boxes iirc, which have Ingo's 'tux' httpd accelerator.
> It might not make the problem go away, but it could make it more
> bearable under high load.   Or it might do absolutely squat depending
> on the ratio of static/dynamic content.
> 

Almost the only dynamic content we have (that actually matters) is 
gitweb.  Everything else is static, with Apache parked in sendfile(). 
Far too often in D state.

	-hpa
