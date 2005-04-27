Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVD0Okt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVD0Okt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 10:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVD0Okt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 10:40:49 -0400
Received: from mail.shareable.org ([81.29.64.88]:57257 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261660AbVD0Okj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 10:40:39 -0400
Date: Wed, 27 Apr 2005 15:40:22 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bulb@ucw.cz, pavel@suse.cz, hch@infradead.org, linuxram@us.ibm.com,
       7eggert@gmx.de, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050427144022.GD1957@mail.shareable.org>
References: <20050426131943.GC2226@openzaurus.ucw.cz> <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu> <20050426201411.GA20109@elf.ucw.cz> <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu> <20050427092450.GB1819@elf.ucw.cz> <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu> <20050427115754.GA8981@vagabond> <E1DQla0-0001vG-00@dorka.pomaz.szeredi.hu> <20050427123944.GA11020@vagabond> <E1DQmUm-0001yy-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DQmUm-0001yy-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> > The userland tools don't need to know. They just need to not be suid.
> 
> But I'd want to continue distribute the non-crippled kernel module
> too, with suid fusermount.  Then fusermount _has_ to know which kernel
> module is currently active.

You can use a version number or feature-bitmask for that.

-- Jamie
