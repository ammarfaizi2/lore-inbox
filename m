Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWJRJxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWJRJxh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 05:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWJRJxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 05:53:36 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:42909 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S932161AbWJRJxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 05:53:36 -0400
Date: Wed, 18 Oct 2006 18:53:28 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Amol Lad <amol@verismonetworks.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc2 : Is something missing in Documentation/dontdiff ?
Message-ID: <20061018095328.GA21977@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Amol Lad <amol@verismonetworks.com>,
	linux kernel <linux-kernel@vger.kernel.org>
References: <1161163537.20400.128.camel@amol.verismonetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161163537.20400.128.camel@amol.verismonetworks.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 02:55:37PM +0530, Amol Lad wrote:
> 1. To start with linux-2.6.19-rc2-orig and linux-2.6.19-rc2 are
> identical
> 2. cd linux-2.6.19-rc2; make allmodconfig; make
> 3. diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff
> linux-2.6.19-rc2-orig linux-2.6.19-rc2 > /tmp/patch
> 
> The above generates 2MB patch file. What is wrong ?
> 
> It seems a new folder is created: linux-2.6.19-rc2/usr/include
> 
This should also be excluded..
