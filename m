Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbUFNLuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbUFNLuK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 07:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUFNLuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 07:50:10 -0400
Received: from [213.146.154.40] ([213.146.154.40]:36565 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262451AbUFNLuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 07:50:08 -0400
Date: Mon, 14 Jun 2004 12:50:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc3-mm2
Message-ID: <20040614115004.GA16054@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040614021018.789265c4.akpm@osdl.org> <20040614111540.GB1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614111540.GB1444@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 04:15:40AM -0700, William Lee Irwin III wrote:
> The arrangement of the #include <linux/kernel.h> in list.h breaks the
> build of documentation. The following patch moves the include to where
> it no longer interferes with kerneldoc's operation.

BUG_ON is in <asm/bug.h>, no need to pull in all the crap from kernel.h

