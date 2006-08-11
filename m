Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWHKUcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWHKUcA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 16:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWHKUcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 16:32:00 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:14267 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932421AbWHKUb7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 16:31:59 -0400
Subject: Re: [PATCH 27/28] elevate writer count for custom 'struct file'
From: Dave Hansen <haveblue@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk, herbert@13thfloor.at
In-Reply-To: <20060803144249.GE920@infradead.org>
References: <20060801235240.82ADCA42@localhost.localdomain>
	 <20060801235300.321FABDD@localhost.localdomain>
	 <20060803144249.GE920@infradead.org>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 13:31:25 -0700
Message-Id: <1155328285.7574.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 15:42 +0100, Christoph Hellwig wrote:
> Please add a helper to create these files so all this happens in just
> one place.  There's a fare bit of code duplication already that this will
> cleanup.  Another nice cleanup you should push out first before doing
> the actual feature :) 

I'm looking at this bit now.  One thing that is a bit confusing is the
internal kernel distinction between a filp and a plain 'struct file'.

Do you have any ideas how you think these interfaces should look?

-- Dave

