Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261607AbTCYHYR>; Tue, 25 Mar 2003 02:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261608AbTCYHYR>; Tue, 25 Mar 2003 02:24:17 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:12554 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261607AbTCYHYR>; Tue, 25 Mar 2003 02:24:17 -0500
Date: Tue, 25 Mar 2003 07:35:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Miles Bader <miles@gnu.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v850]  Include <asm/string.h> in v850 simcons.c
Message-ID: <20030325073524.A30897@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miles Bader <miles@gnu.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030325025659.307B037CD@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030325025659.307B037CD@mcspd15.ucom.lsi.nec.co.jp>; from miles@lsi.nec.co.jp on Tue, Mar 25, 2003 at 11:56:59AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 11:56:59AM +0900, Miles Bader wrote:
>  #include <asm/poll.h>
> +#include <asm/string.h>

Please always use <linux/string.h> instead of the asm variant.

