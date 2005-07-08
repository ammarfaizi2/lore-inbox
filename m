Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262776AbVGHTPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbVGHTPM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbVGHTNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:13:32 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:54452 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262776AbVGHTLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:11:54 -0400
Date: Fri, 8 Jul 2005 21:11:21 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Pekka J Enberg <penberg@cs.helsinki.fi>
cc: Bryan Henderson <hbryan@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       bfields@fieldses.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxram@us.ibm.com, mike@waychison.com,
       Miklos Szeredi <miklos@szeredi.hu>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: share/private/slave a subtree - define vs enum
In-Reply-To: <courier.42CEC422.00001C6C@courier.cs.helsinki.fi>
Message-ID: <Pine.LNX.4.61.0507082108530.3728@scrub.home>
References: <OFB01287B5.D35EDB80-ON88257038.005DEE97-88257038.005EDB8B@us.ibm.com>
 <courier.42CEC422.00001C6C@courier.cs.helsinki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 8 Jul 2005, Pekka J Enberg wrote:

> I don't see how the following is tortured: 
> enum {
>       PNODE_MEMBER_VFS  = 0x01,
>       PNODE_SLAVE_VFS   = 0x02
> }; 
> In fact, I think it is more natural. An almost identical example even appears
> in K&R. 

So it basically comes down to personal preference, if the original uses 
defines and it works fine, I don't really see a good enough reason to 
change it to enums, so please leave the decision to author.

bye, Roman
