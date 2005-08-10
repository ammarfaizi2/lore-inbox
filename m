Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932577AbVHJWXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbVHJWXd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 18:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbVHJWXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 18:23:33 -0400
Received: from smtp.istop.com ([66.11.167.126]:43185 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S932577AbVHJWXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 18:23:33 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] Rename PageChecked as PageMiscFS
Date: Thu, 11 Aug 2005 08:23:53 +1000
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>, David Howells <dhowells@redhat.com>
References: <42F57FCA.9040805@yahoo.com.au> <20050808145430.15394c3c.akpm@osdl.org> <200508110812.59986.phillips@arcor.de>
In-Reply-To: <200508110812.59986.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508110823.53593.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note: I have not fully audited the NFS-related colliding use of page flags bit 
8, to verify that it really does not escape into VFS or MM from NFS, in fact 
I have misgivings about end_page_fs_misc which uses this flag but has no 
in-tree users to show how it is used and, hmm, isn't even _GPL.  What is up?

And note the wrongness tacked onto the end of page-flags.h.  I didn't do it!

Regards,

Daniel
