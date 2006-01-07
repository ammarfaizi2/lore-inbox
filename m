Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbWAGFHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbWAGFHG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 00:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965331AbWAGFHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 00:07:06 -0500
Received: from kanga.kvack.org ([66.96.29.28]:12936 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S965028AbWAGFHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 00:07:05 -0500
Date: Sat, 7 Jan 2006 00:03:13 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: NFS processes gettting stuck in D with currrent git
Message-ID: <20060107050313.GA16451@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

One of the NFS patches seems to have introduced a problem with the nfs 
client, as my test box now seems to be hanging processes in D somewhat 
randomly (RHEL4 box for the server).  I'll try to bisect it if there 
aren't any obvious candidates for the problem.  Cheers, 

		-ben
-- 
"You know, I've seen some crystals do some pretty trippy shit, man."
Don't Email: <dont@kvack.org>.
