Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262708AbSJWQSQ>; Wed, 23 Oct 2002 12:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262648AbSJWQSQ>; Wed, 23 Oct 2002 12:18:16 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:57101 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262800AbSJWQSJ>; Wed, 23 Oct 2002 12:18:09 -0400
Date: Wed, 23 Oct 2002 17:24:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Smalley <sds@tislabs.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
       Russell Coker <russell@coker.com.au>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021023172407.A14270@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Smalley <sds@tislabs.com>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Russell Coker <russell@coker.com.au>, linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com
References: <20021023155457.L2732@redhat.com> <Pine.GSO.4.33.0210231112420.7042-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.33.0210231112420.7042-100000@raven>; from sds@tislabs.com on Wed, Oct 23, 2002 at 12:09:47PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 12:09:47PM -0400, Stephen Smalley wrote:
> If we migrate SELinux to using extended attributes to store file security
> contexts (pending their merging into 2.5), then we could replace the
> extended *stat with getxattr,

extended attributes are both in 2.4.20-pre and 2.5 (for a long time).

