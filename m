Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVDMDHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVDMDHw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 23:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbVDMDEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 23:04:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42217 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262656AbVDMDDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 23:03:15 -0400
Date: Wed, 13 Apr 2005 04:03:14 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] sound/oss/rme96xx.c: fix two check after use
Message-ID: <20050413030313.GT8859@parcelfarce.linux.theplanet.co.uk>
References: <20050413021742.GT3631@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050413021742.GT3631@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 04:17:42AM +0200, Adrian Bunk wrote:
> This patch fixes two check after use found by the Coverity checker.

Bullshit.  ->private_data is set by rme96xx_open() to guaranteed non-NULL
and never changed elsewhere.  Same comment about reading the fscking
source, BUG_ON(), etc.
