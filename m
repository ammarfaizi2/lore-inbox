Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316499AbSILQgk>; Thu, 12 Sep 2002 12:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316578AbSILQgk>; Thu, 12 Sep 2002 12:36:40 -0400
Received: from air-2.osdl.org ([65.172.181.6]:14473 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316499AbSILQgj>;
	Thu, 12 Sep 2002 12:36:39 -0400
Date: Thu, 12 Sep 2002 09:41:29 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: jw schultz <jw@pegasys.ws>
cc: linux-kernel@vger.kernel.org, <Matt_Domsch@Dell.com>
Subject: Re: the userspace side of driverfs
In-Reply-To: <20020912051127.GH10315@pegasys.ws>
Message-ID: <Pine.LNX.4.44.0209120938400.1057-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > For such cases where the data being exported is really binary,
> > having a common set of parse/unparse routines would be nice. 
> 
> I don't know what others think of this but i'd say that some
> binary files are appropriate.  

Not a chance. The values will be ASCII, and that's all there is to it. If 
I see someone exporting a binary file in driverfs, I'll submit a patch to 
remove it. :)

Matt, I'm interested in working on exporting the EFI variables in an 
ASCII manner, though time constraints are a bit stiff, and it's been a 
while sincce I looked at anything EFI. Stay tuned...

	-pat

