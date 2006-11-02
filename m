Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWKBOoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWKBOoO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 09:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWKBOoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 09:44:14 -0500
Received: from brick.kernel.dk ([62.242.22.158]:43076 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1750954AbWKBOoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 09:44:13 -0500
Date: Thu, 2 Nov 2006 15:46:04 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: martin <mp3@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/5] I/O statistics through request queues
Message-ID: <20061102144603.GN13555@kernel.dk>
References: <20061023113728.GM8251@kernel.dk> <453D05C3.7040104@de.ibm.com> <20061023200220.GB4281@kernel.dk> <453E38FE.1020306@de.ibm.com> <20061024162050.GK4281@kernel.dk> <453E9C18.70803@de.ibm.com> <20061025051238.GO4281@kernel.dk> <453F3D4E.4020608@de.ibm.com> <20061025104217.GB4281@kernel.dk> <1162478356.6902.144.camel@dix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162478356.6902.144.camel@dix>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02 2006, martin wrote:
> Jens, Andrew,
> I am not pursueing this patch set. I have convinced myself that blktrace
> is capable of being used as a an analysis tool for low level I/O
> performance, if invoced with appropriate settings. In our tests, we
> limited traces to Issue/Complete events, cut down on relay buffers, and
> redirected traces to a network connection instead of filling locally
> attached storage up. Cost is about 2 percent, as advertised.

Martin, thanks for following up on this and verifying the cost numbers.

-- 
Jens Axboe

