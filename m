Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbTDTSku (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 14:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263672AbTDTSku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 14:40:50 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:38916 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263661AbTDTSkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 14:40:49 -0400
Date: Sun, 20 Apr 2003 19:52:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new system call mknod64
Message-ID: <20030420195249.A14634@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <UTC200304201839.h3KIdWk18226.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200304201839.h3KIdWk18226.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Sun, Apr 20, 2003 at 08:39:32PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 20, 2003 at 08:39:32PM +0200, Andries.Brouwer@cwi.nl wrote:
> Change the type of the mknod arg from dev_t to unsigned int.
> Add (for i386) mknod64.

Please make the argument for mknod/mknod64 __u32/__u64.  And I
don't think adding the syscall makes sense before the internal
dev_t represantion has changed.

