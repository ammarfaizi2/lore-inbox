Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262495AbSJDQ7V>; Fri, 4 Oct 2002 12:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbSJDQ7M>; Fri, 4 Oct 2002 12:59:12 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:7684 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262495AbSJDQ6o>; Fri, 4 Oct 2002 12:58:44 -0400
Date: Fri, 4 Oct 2002 18:04:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mark Peloquin <peloquin@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: [PATCH] EVMS core 1/4: evms.c
Message-ID: <20021004180417.A3958@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mark Peloquin <peloquin@us.ibm.com>, linux-kernel@vger.kernel.org,
	evms-devel@lists.sourceforge.net
References: <OF9683DE97.19D23CC6-ON85256C48.005CD740@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF9683DE97.19D23CC6-ON85256C48.005CD740@pok.ibm.com>; from peloquin@us.ibm.com on Fri, Oct 04, 2002 at 12:07:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This was done to abstract the storage/lookup
> method. Currently with only 256 minors per major
> a simply kernel list is adequate, however once
> the kernel goes to 20-bit minors a list will not
> be sufficient.

Before that happens you'll get nice private pointers in the higher
level objects so you don't need to do lookups in any fast-path
anymore..

