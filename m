Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161217AbWAMHoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161217AbWAMHoN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 02:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161228AbWAMHoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 02:44:12 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:19328 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1161217AbWAMHoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 02:44:12 -0500
Date: Fri, 13 Jan 2006 09:44:10 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [PATCH] reiserfs: remove kmalloc wrapper
In-Reply-To: <20060112233920.4b3b0a26.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0601130942540.20349@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0601130930130.17696@sbz-30.cs.Helsinki.FI>
 <20060112233920.4b3b0a26.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
> > This patch removes kmalloc() wrapper from fs/reiserfs/. Please note that 
> >  a reiserfs /proc entry format is changed because kmalloc statistics is 
> >  removed.

On Thu, 12 Jan 2006, Andrew Morton wrote:
> I wonder if it'd be safer to just spit out a zero where that number used to
> be?

Yup but then again it has no business being there in the first place. 
Please let me know if you like printing out zero instead and I'll whack up 
a patch.

			Pekka
