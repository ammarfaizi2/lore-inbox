Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262621AbVAEVyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbVAEVyI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 16:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbVAEVvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 16:51:49 -0500
Received: from vintereik.ii.uib.no ([129.177.16.237]:56961 "EHLO
	vintereik.ii.uib.no") by vger.kernel.org with ESMTP id S262611AbVAEVsm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 16:48:42 -0500
Date: Wed, 5 Jan 2005 22:38:37 +0100
From: Jan-Frode Myklebust <Jan-Frode.Myklebust@bccs.uib.no>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Eirik Thorsnes <eithor@ii.uib.no>, smfrench@austin.rr.com,
       trond.myklebust@fys.uio.no, matthew@wil.cx
Subject: Re: panic - Attempting to free lock with active block list
Message-ID: <20050105213837.GA29447@ii.uib.no>
Mail-Followup-To: Chris Wright <chrisw@osdl.org>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
	Eirik Thorsnes <eithor@ii.uib.no>, smfrench@austin.rr.com,
	trond.myklebust@fys.uio.no, matthew@wil.cx
References: <20050105195736.GA26989@ii.uib.no> <20050105123207.J469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050105123207.J469@build.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 12:32:07PM -0800, Chris Wright wrote:
> 
> It seems likely it's nfs related in this case since it stresses the
> fs/locks code differently than local filesystems.  I recall Steve French
> reporting similar issue with cifs last month.

Also found this on the linux-cifs-client list:

	http://lists.samba.org/archive/linux-cifs-client/2004-December/000617.html

Is the suggested fix also relevant for fs/nfs/file.c ?

 
   -jf
