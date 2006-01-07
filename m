Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161091AbWAGUqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161091AbWAGUqr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 15:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161096AbWAGUqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 15:46:47 -0500
Received: from pat.uio.no ([129.240.130.16]:34790 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1161091AbWAGUqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 15:46:47 -0500
Subject: Re: NFS processes gettting stuck in D with currrent git
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060107050313.GA16451@kvack.org>
References: <20060107050313.GA16451@kvack.org>
Content-Type: text/plain
Date: Sat, 07 Jan 2006 15:46:34 -0500
Message-Id: <1136666794.7860.12.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.05, required 12,
	autolearn=disabled, AWL 1.76, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-07 at 00:03 -0500, Benjamin LaHaise wrote:
> Hi Trond,
> 
> One of the NFS patches seems to have introduced a problem with the nfs 
> client, as my test box now seems to be hanging processes in D somewhat 
> randomly (RHEL4 box for the server).  I'll try to bisect it if there 
> aren't any obvious candidates for the problem.  Cheers, 

Does a magic sysrq-t give any useful clues as to where they are hanging?

Cheers,
  Trond

