Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030315AbVIISQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbVIISQz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 14:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbVIISQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 14:16:55 -0400
Received: from thunk.org ([69.25.196.29]:37301 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030315AbVIISQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 14:16:54 -0400
Date: Fri, 9 Sep 2005 14:16:49 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, sct@redhat.com, akpm@osdl.org,
       adilger@clusterfs.com, ext3-users@redhat.com
Subject: Re: [PATCH 1/6] jbd: remove duplicated debug print
Message-ID: <20050909181649.GC24228@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
	sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com,
	ext3-users@redhat.com
References: <20050909084214.GB14205@miraclelinux.com> <20050909084342.GC14205@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909084342.GC14205@miraclelinux.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 05:43:42PM +0900, Akinobu Mita wrote:
> remove duplicated debug print

> -	jbd_debug(3, "JBD: commit phase 2\n");
> -

If you're going to do this, please renumber the rest of the "commit
phase n" messages.  Or the debugging messages will look very funny.

						- Ted
