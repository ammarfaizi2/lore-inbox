Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262653AbSJWQa2>; Wed, 23 Oct 2002 12:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbSJWQa2>; Wed, 23 Oct 2002 12:30:28 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:526 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262653AbSJWQa1>; Wed, 23 Oct 2002 12:30:27 -0400
Date: Wed, 23 Oct 2002 17:36:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Smalley <sds@tislabs.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
       Russell Coker <russell@coker.com.au>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021023173635.A15896@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Smalley <sds@tislabs.com>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Russell Coker <russell@coker.com.au>, linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com
References: <20021023172407.A14270@infradead.org> <Pine.GSO.4.33.0210231231470.7042-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.33.0210231231470.7042-100000@raven>; from sds@tislabs.com on Wed, Oct 23, 2002 at 12:34:05PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 12:34:05PM -0400, Stephen Smalley wrote:
> 
> On Wed, 23 Oct 2002, Christoph Hellwig wrote:
> 
> > extended attributes are both in 2.4.20-pre and 2.5 (for a long time).
> 
> I meant the merging of the EA implementations for ext[23], not just the
> EA API calls.

Why are you limited to a single fs?  xfs and jfs have xattr support
out of the box (in 2.4 only jfs is actually in the mainline tree, though)

