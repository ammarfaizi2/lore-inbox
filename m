Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbUB2WYR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 17:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbUB2WYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 17:24:17 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:12040 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262166AbUB2WYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 17:24:16 -0500
Date: Sun, 29 Feb 2004 22:24:15 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc1-mm1
Message-ID: <20040229222415.A32236@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040229140617.64645e80.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040229140617.64645e80.akpm@osdl.org>; from akpm@osdl.org on Sun, Feb 29, 2004 at 02:06:17PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 29, 2004 at 02:06:17PM -0800, Andrew Morton wrote:
> +scsi-external-build-fix.patch
> 
> Fix scsi.h for inclusion by userspace apps - it used to work, so...

This has been rejected on linux-scsi a few times.  Don't use include/scsi/
from the kerneltree - there's alredy a /usr/include/scsi from glibc anyway,
so the situation is even more clear thæn the general you should not include
kernel headers thing.

