Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbTIKRK3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbTIKRK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:10:29 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:49041 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261399AbTIKRK2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:10:28 -0400
Date: Thu, 11 Sep 2003 18:09:44 +0100
From: Jamie Lokier <jamie@shareable.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] kmalloc + memset(foo, 0, bar) = kmalloc0
Message-ID: <20030911170944.GG29532@mail.jlokier.co.uk>
References: <200309111540.58729@bilbo.math.uni-mannheim.de> <20030911134557.GV454@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911134557.GV454@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> Bad choice of name - too easy to confuse with kmalloc().

kmalloc_and_zero() would be much clearer.

It opens the way for a pool of pre-zeroed pages, too.  We know that
improves preformance on some architectures.

-- Jamie
