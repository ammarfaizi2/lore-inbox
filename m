Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTE2LSj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 07:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbTE2LSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 07:18:38 -0400
Received: from holomorphy.com ([66.224.33.161]:14727 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262164AbTE2LPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 07:15:40 -0400
Date: Thu, 29 May 2003 04:28:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Stewart Smith <stewartsmith@mac.com>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: buffer_head.b_bsize type
Message-ID: <20030529112841.GA8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Stewart Smith <stewartsmith@mac.com>, linux-kernel@vger.kernel.org,
	trivial@rustcorp.com.au
References: <746529B0-91C0-11D7-9488-00039346F142@mac.com> <20030529103503.GZ8978@holomorphy.com> <20030529111517.GP14138@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529111517.GP14138@parcelfarce.linux.theplanet.co.uk>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 03:35:03AM -0700, William Lee Irwin III wrote:
>> Could we go the other way and make all users of b_size use unsigned?

On Thu, May 29, 2003 at 12:15:17PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> Who the hell cares?  Size of buffer does not exceed the page size.
> Unless you can show a platform with 2Gb pages...

The thought behind my comment was that it didn't make sense to allow
the representation to go negative. There of course shouldn't ever be
any need to allow >= 2GB b_size to be representable.

I'll defer to viro here.


-- wli
