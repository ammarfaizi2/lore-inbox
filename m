Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268954AbUIBUIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268954AbUIBUIe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268261AbUIBUIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:08:22 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:19645 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268336AbUIBUH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:07:57 -0400
Date: Thu, 2 Sep 2004 13:07:43 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Amit Gud <amitgud@gmail.com>
Cc: linux-kernel@vger.kernel.org, gud@eth.net
Subject: Re: Using filesystem blocks
Message-ID: <20040902200743.GB6875@taniwha.stupidest.org>
References: <2c6b3ab004090212293b394b41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c6b3ab004090212293b394b41@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 12:59:42AM +0530, Amit Gud wrote:

> Is it wise enough to abstract away the usage of blocks for storing
> extended attributes?

No.  Some fs' will store xattr data in the inodes if it fits.


  --cw
