Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262813AbVGHTnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbVGHTnD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbVGHTl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:41:26 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:60308 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262813AbVGHTjR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:39:17 -0400
Subject: Re: share/private/slave a subtree - define vs enum
From: Ram <linuxram@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>,
       Bryan Henderson <hbryan@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       bfields@fieldses.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, mike@waychison.com,
       Miklos Szeredi <miklos@szeredi.hu>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <Pine.LNX.4.61.0507082108530.3728@scrub.home>
References: <OFB01287B5.D35EDB80-ON88257038.005DEE97-88257038.005EDB8B@us.ibm.com>
	 <courier.42CEC422.00001C6C@courier.cs.helsinki.fi>
	 <Pine.LNX.4.61.0507082108530.3728@scrub.home>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1120851535.30164.155.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Jul 2005 12:38:55 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-08 at 12:11, Roman Zippel wrote:
> Hi,
> 
> On Fri, 8 Jul 2005, Pekka J Enberg wrote:
> 
> > I don't see how the following is tortured: 
> > enum {
> >       PNODE_MEMBER_VFS  = 0x01,
> >       PNODE_SLAVE_VFS   = 0x02
> > }; 
> > In fact, I think it is more natural. An almost identical example even appears
> > in K&R. 
> 
> So it basically comes down to personal preference, if the original uses 
> defines and it works fine, I don't really see a good enough reason to 
> change it to enums, so please leave the decision to author.

Ok. I will change to enums whereever I define new categories of
#defines. And leave the #defines for already existing category as is.

RP


