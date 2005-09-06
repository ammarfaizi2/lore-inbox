Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVIFSNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVIFSNa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 14:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVIFSN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 14:13:29 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:34717 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1750765AbVIFSN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 14:13:29 -0400
Date: Tue, 6 Sep 2005 14:13:27 -0400
To: Bret Towe <magnade@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs4 client bug
Message-ID: <20050906181327.GE10632@fieldses.org>
References: <dda83e7805090320053b03615d@mail.gmail.com> <20050904103523.GA5613@electric-eye.fr.zoreil.com> <dda83e78050904124454fc675a@mail.gmail.com> <dda83e78050904135113b95c4a@mail.gmail.com> <20050904215219.GA9812@fieldses.org> <dda83e780509042008294fbe26@mail.gmail.com> <20050905031825.GA22209@fieldses.org> <dda83e78050905134420f06fbf@mail.gmail.com> <9a87484905090513481118e67b@mail.gmail.com> <dda83e7805090520407aefb4d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dda83e7805090520407aefb4d1@mail.gmail.com>
User-Agent: Mutt/1.5.10i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 08:40:53PM -0700, Bret Towe wrote:
> Pid: 14169, comm: xmms Tainted: G   M  2.6.13

Hm, can someone explain what that means?  A proprietary module was
loaded then unloaded, maybe?

You may also want to retest with

http://www.citi.umich.edu/projects/nfsv4/linux/kernel-patches/2.6.13-1/linux-2.6.13-001-NFS_ALL_MODIFIED.dif

applied, to make sure there isn't a patch in Trond's series that already
fixes the bug.

--b.
