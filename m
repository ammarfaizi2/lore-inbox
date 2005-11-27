Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbVK0JfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbVK0JfF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 04:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbVK0JfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 04:35:04 -0500
Received: from adsl-80.mirage.euroweb.hu ([193.226.228.80]:54025 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1750899AbVK0JfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 04:35:03 -0500
To: viro@ftp.linux.org.uk
CC: akpm@osdl.org, linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <20051127063216.GC27946@ftp.linux.org.uk> (message from Al Viro
	on Sun, 27 Nov 2005 06:32:16 +0000)
Subject: Re: [PATCH 2/2] shared mounts: save mount flag space
References: <E1EfJfC-00016e-00@dorka.pomaz.szeredi.hu> <E1EfJnm-00017H-00@dorka.pomaz.szeredi.hu> <E1EfK2o-0001AK-00@dorka.pomaz.szeredi.hu> <20051126215509.073cb957.akpm@osdl.org> <20051127063216.GC27946@ftp.linux.org.uk>
Message-Id: <E1EgIvH-0001eN-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 27 Nov 2005 10:34:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Anyway, I'll let Ram&Al decide on this proposal.
> 
> It's
> 	a) palliative
> 	b) ugly
> 
> Let's face it, mount(2) ABI is getting past its shelf life already.
> We'll need saner replacement (not mixing action with the flags and
> being really typed) anyway,

Could you please ellaborate a bit more?

Are you thinking of a separate syscall for each action?

Miklos
