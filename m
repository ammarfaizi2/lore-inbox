Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVACItM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVACItM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 03:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVACItL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 03:49:11 -0500
Received: from gw.c9x.org ([213.41.131.17]:53278 "HELO
	nerim.mx.42-networks.com") by vger.kernel.org with SMTP
	id S261410AbVACItH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 03:49:07 -0500
Date: Mon, 3 Jan 2005 09:48:44 +0059
From: "Frank Denis \(Jedi/Sector One\)" <lkml@pureftpd.org>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at fs/namei.c:2333 (reiserfs related?)
Message-ID: <20050103084906.GA11374@c9x.org>
References: <20041227112349.GA29389@c9x.org> <20041228203105.57467469.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041228203105.57467469.akpm@osdl.org>
X-Operating-System: OpenBSD - http://www.openbsd.org/
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2004 at 08:31:05PM -0800, Andrew Morton wrote:
> Were filesystem quotas in use at the time?

  No, and Vlad's patches were already applied.
  
  FYI I just hit exactly the same bug on two different hosts (busy NFS
servers).
