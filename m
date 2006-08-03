Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbWHCOsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbWHCOsM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 10:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWHCOsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 10:48:12 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:41674 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S932473AbWHCOsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 10:48:10 -0400
Date: Thu, 3 Aug 2006 08:48:08 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Valerie Henson <val_henson@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Akkana Peck <akkana@shallowsky.com>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Jesse Barnes <jesse.barnes@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, Chris Wedgwood <cw@f00f.org>,
       jsipek@cs.sunysb.edu, Al Viro <viro@ftp.linux.org.uk>,
       Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC] [PATCH] Relative lazy atime
Message-ID: <20060803144808.GA4379@parisc-linux.org>
References: <20060803063622.GB8631@goober>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803063622.GB8631@goober>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 11:36:22PM -0700, Valerie Henson wrote:
> (Corrected Chris Wedgwood's name and email.)
> 
> My friend Akkana followed my advice to use noatime on one of her
> machines, but discovered that mutt was unusable because it always
> thought that new messages had arrived since the last time it had
> checked a folder (mbox format).  I thought this was a bummer, so I

This is why people normally recommend "nodiratime" ...
