Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263264AbTDGFqq (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 01:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263265AbTDGFqq (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 01:46:46 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:28425 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263264AbTDGFqp (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 01:46:45 -0400
Date: Mon, 7 Apr 2003 06:58:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Fabrice Bellard <fabrice.bellard@free.fr>, linux-kernel@vger.kernel.org,
       paulus@samba.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Qemu support for PPC
Message-ID: <20030407065813.A27933@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Fabrice Bellard <fabrice.bellard@free.fr>,
	linux-kernel@vger.kernel.org, paulus@samba.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20030407024858.C32422C014@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030407024858.C32422C014@lists.samba.org>; from rusty@rustcorp.com.au on Mon, Apr 07, 2003 at 12:40:38PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 12:40:38PM +1000, Rusty Russell wrote:
> Paul, is this OK?
> 
> I'd like it in 2.4.21 if possible.

Please use sys_personality from userland.  And not, I don't think it should
go into 2.4.21.  Get it into 2.5 first.

