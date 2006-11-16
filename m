Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754886AbWKPWxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886AbWKPWxh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 17:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755489AbWKPWxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 17:53:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44760 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1754886AbWKPWxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 17:53:36 -0500
Subject: Re: [PATCH] hfs: correct return value in hfs_fill_super()
From: Eric Paris <eparis@parisplace.org>
To: linux-kernel@vger.kernel.org
Cc: zippel@linux-m68k.org
In-Reply-To: <1163715533.22367.10.camel@localhost.localdomain>
References: <1163715533.22367.10.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 17:51:05 -0500
Message-Id: <1163717465.22367.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-16 at 17:18 -0500, Eric Paris wrote:
> When an invalid hfs filesystem image is mounted it may cause a number of
> different oops.  One filesystem image which triggers this problem can be
> found at:
> 

Whoops, appears to be the same as the post from Eric Sandeen on tuesday
with subject 

[PATCH] hfs_fill_super returns success even if no root inode

please disregard.

