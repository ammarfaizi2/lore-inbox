Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261726AbTCZPbj>; Wed, 26 Mar 2003 10:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261727AbTCZPbj>; Wed, 26 Mar 2003 10:31:39 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:33028 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261726AbTCZPbi>; Wed, 26 Mar 2003 10:31:38 -0500
Date: Wed, 26 Mar 2003 15:42:47 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] s390 update (3/9): listing & kerntypes.
Message-ID: <20030326154247.A17795@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <200303261607.31310.schwidefsky@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303261607.31310.schwidefsky@de.ibm.com>; from schwidefsky@de.ibm.com on Wed, Mar 26, 2003 at 04:07:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 04:07:31PM +0100, Martin Schwidefsky wrote:
> Remove rule to generate kernel listing. Add code to generate kerntypes for
> use with the lkcd utils.

No.  Either we add Kerntypes to the architecture-independent code (I'm all
for it!) or not at all.  Cludging this into s390-specific code is a very,
very bad idea.

