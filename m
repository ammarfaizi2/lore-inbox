Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261268AbSIPJXY>; Mon, 16 Sep 2002 05:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261289AbSIPJXY>; Mon, 16 Sep 2002 05:23:24 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:22794 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261268AbSIPJXY>; Mon, 16 Sep 2002 05:23:24 -0400
Date: Mon, 16 Sep 2002 10:28:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Peter Waechtler <pwaechtler@mac.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.20-pre7: export proc_get_inode
Message-ID: <20020916102809.A18981@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Peter Waechtler <pwaechtler@mac.com>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
References: <15532699-C8C8-11D6-B517-00039387C942@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15532699-C8C8-11D6-B517-00039387C942@mac.com>; from pwaechtler@mac.com on Sun, Sep 15, 2002 at 06:27:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2002 at 06:27:53PM +0200, Peter Waechtler wrote:
> this is a patch against 2.4.20-pre7 to export proc_get_inode(). This is
> needed to compile and load the wlan/comx driver as a module

This comes up about every month and the answer is that it should not be
exported because the driver is broken.

