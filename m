Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265860AbUA1G6T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 01:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265869AbUA1G6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 01:58:19 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:26519 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S265860AbUA1G6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 01:58:18 -0500
Date: Tue, 27 Jan 2004 22:57:35 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: hanasaki <hanasaki@hanaden.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS rpc and stale handles on 2.6.x servers
Message-ID: <20040128065735.GB2445@srv-lnx2600.matchmail.com>
Mail-Followup-To: hanasaki <hanasaki@hanaden.com>,
	linux-kernel@vger.kernel.org
References: <40145E3A.5050704@hanaden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40145E3A.5050704@hanaden.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 06:24:26PM -0600, hanasaki wrote:
> The below is being reported, on and off, when hitting nfs-kernel-servers 
> running on 2.6.0 and 2.6.1  Could someone tell me if this is smoe bug or 
> what?  Thanks
> 	RPC request reserved 0 but used 124
> 
> Debian sarge
> nfs-kernel-server
> am-untils
> nfsv3 over tcp

I get this also, and the comments in the code suggest that it is a bug.

Asking Niel and Trond will help getting this answered...
