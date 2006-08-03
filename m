Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbWHCOc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbWHCOc7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 10:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWHCOc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 10:32:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51610 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932519AbWHCOc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 10:32:58 -0400
Date: Thu, 3 Aug 2006 15:32:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk, herbert@13thfloor.at,
       hch@infradead.org
Subject: Re: [PATCH 01/28] prepare for write access checks: collapse if()
Message-ID: <20060803143252.GA920@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
	viro@ftp.linux.org.uk, herbert@13thfloor.at
References: <20060801235240.82ADCA42@localhost.localdomain> <20060801235240.2E3AC38D@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801235240.2E3AC38D@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 04:52:40PM -0700, Dave Hansen wrote:
> 
> We're shortly going to be adding a bunch more permission
> checks in these functions.  That requires adding either a
> bunch of new if() conditions, or some gotos.  This patch
> collapses existing if()s and uses gotos instead to
> prepare for the upcoming changes.

Ok, please send this to akpm for inclusion ASAP so the patch series shrinks.

