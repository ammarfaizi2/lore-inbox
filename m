Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263194AbTCWUh0>; Sun, 23 Mar 2003 15:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263192AbTCWUh0>; Sun, 23 Mar 2003 15:37:26 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:54030 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263194AbTCWUhZ>; Sun, 23 Mar 2003 15:37:25 -0500
Date: Sun, 23 Mar 2003 20:48:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dominik Kubla <dominik@kubla.de>
Cc: Jan Dittmer <j.dittmer@portrix.net>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: i2c-via686a driver
Message-ID: <20030323204810.A11421@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dominik Kubla <dominik@kubla.de>,
	Jan Dittmer <j.dittmer@portrix.net>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <3E7E0B37.5060505@portrix.net> <20030323202743.A11150@infradead.org> <200303232136.10089.dominik@kubla.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303232136.10089.dominik@kubla.de>; from dominik@kubla.de on Sun, Mar 23, 2003 at 09:36:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23, 2003 at 09:36:10PM +0100, Dominik Kubla wrote:
> Why? It's a valid C99 feature and since the kernel already uses C99 
> initializers it won't compile with compilers that choke on C99 comments 
> anyway.

Because there's a strong preference for traditional C style in the kernel.
typedefs are also a valid C feature and we try to avoid them.

