Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261990AbTCZT4P>; Wed, 26 Mar 2003 14:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261988AbTCZT4P>; Wed, 26 Mar 2003 14:56:15 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:36614 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262001AbTCZTzg>; Wed, 26 Mar 2003 14:55:36 -0500
Date: Wed, 26 Mar 2003 20:06:47 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] s390 update (3/9): listing & kerntypes.
Message-ID: <20030326200647.C21308@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <OF72A4868D.BBBD469B-ONC1256CF5.005A937E@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF72A4868D.BBBD469B-ONC1256CF5.005A937E@de.ibm.com>; from schwidefsky@de.ibm.com on Wed, Mar 26, 2003 at 05:32:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 05:32:12PM +0100, Martin Schwidefsky wrote:
> 
> > No.  Either we add Kerntypes to the architecture-independent code (I'm
> all
> > for it!) or not at all.  Cludging this into s390-specific code is a very,
> > very bad idea.
> Well, even if the Kerntypes gets added to the architecture-independent code
> we still would need some special s390 includes to get all the types we need.

The patches from the lkcd folks don't seem to need additional includes.
Please argue with them instead of trying to push such changes through the
backdoor.

