Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbVKMEUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbVKMEUp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 23:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbVKMEUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 23:20:45 -0500
Received: from mail.fieldses.org ([66.93.2.214]:39361 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751335AbVKMEUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 23:20:44 -0500
Date: Sat, 12 Nov 2005 23:20:43 -0500
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS question: what's the use of nfs3_async_handle_jukebox?
Message-ID: <20051113042043.GA18838@fieldses.org>
References: <4ae3c140511121244v3cfdb3c6v133d67d8fa42c46b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c140511121244v3cfdb3c6v133d67d8fa42c46b@mail.gmail.com>
User-Agent: Mutt/1.5.11
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 03:44:35PM -0500, Xin Zhao wrote:
> I am reading the NFS codes, but got stuck at the
> nfs3_async_handle_jukebox() function. What's the use of this function?
> IS there any document about this? Thanks!

It just delays and then retries the original rpc call.  See the
explanation of NFSERR_JUKEBOX in rfc 1813.

--b.
