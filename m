Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266505AbUIISWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUIISWo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUIISWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 14:22:44 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:47112 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266505AbUIIR5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:57:15 -0400
Date: Thu, 9 Sep 2004 18:57:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mingming Cao <cmm@us.ibm.com>, Badari Pulavarty <pbadari@us.ibm.com>,
       Ram Pai <linuxram@us.ibm.com>
Subject: Re: [Patch 2/6]: ext3 reservations: Renumber the ext3 reservations ioctls
Message-ID: <20040909185702.A13111@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Mingming Cao <cmm@us.ibm.com>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Ram Pai <linuxram@us.ibm.com>
References: <200409071302.i87D2ROd030909@sisko.scot.redhat.com> <20040907235327.A21397@infradead.org> <1094636497.1985.20.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1094636497.1985.20.camel@sisko.scot.redhat.com>; from sct@redhat.com on Wed, Sep 08, 2004 at 10:41:38AM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 10:41:38AM +0100, Stephen C. Tweedie wrote:
> Hi,
> 
> On Tue, 2004-09-07 at 23:53, Christoph Hellwig wrote:
> 
> > Maybe you could reuse the XFS reservation ioctls instead of adding
> > another set?  Having incompatible APIs for the same thing on different
> > filesystems sounds like the wrong way to go.
> 
> I don't mind either way.  But I just looked, and I think they are doing
> different things.  If I'm reading the XFS bits right, the XFS ioctls
> actively reserve/free disk space; but the ext3 ones do nothing except
> set/query the size of the per-inode sliding reservation window.
> 
> So sounds like they are best kept separate for now.

makes sense.

