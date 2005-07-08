Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262610AbVGHM0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbVGHM0f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 08:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVGHM02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 08:26:28 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:20714 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262594AbVGHM0X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 08:26:23 -0400
References: <1120816072.30164.10.camel@localhost>
            <1120816229.30164.13.camel@localhost>
            <1120817463.30164.43.camel@localhost>
            <84144f0205070804171d7c9726@mail.gmail.com>
            <Pine.LNX.4.61.0507081412280.3743@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0507081412280.3743@scrub.home>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Pekka Enberg <penberg@gmail.com>, Ram <linuxram@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       mike@waychison.com, bfields@fieldses.org,
       Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: share/private/slave a subtree
Date: Fri, 08 Jul 2005 15:26:22 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42CE70EE.000029AA@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2005, Pekka Enberg wrote:
> > > +#define PNODE_MEMBER_VFS  0x01
> > > +#define PNODE_SLAVE_VFS   0x02
> > 
> > Enums, please.

Roman Zippel writes:
> Is this becoming a requirement now? I personally would rather leave that 
> to personal preference...

Hey, I just review patches. I don't get to set requirements. There's a 
reason why enums are preferred though. They define a proper name for the 
constant. It's far to easy to mess up with #defines. They also document the 
code intent much better as you can group related constants together. 

                 Pekka
