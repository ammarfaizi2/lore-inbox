Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267001AbSKLVzZ>; Tue, 12 Nov 2002 16:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267003AbSKLVzZ>; Tue, 12 Nov 2002 16:55:25 -0500
Received: from pizda.ninka.net ([216.101.162.242]:60608 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267001AbSKLVzY>;
	Tue, 12 Nov 2002 16:55:24 -0500
Date: Tue, 12 Nov 2002 14:00:28 -0800 (PST)
Message-Id: <20021112.140028.48834266.davem@redhat.com>
To: rml@tech9.net
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module_name()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1037133554.2794.18.camel@phantasy>
References: <20021112174741.6073E2C2B2@lists.samba.org>
	<1037133554.2794.18.camel@phantasy>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Robert Love <rml@tech9.net>
   Date: 12 Nov 2002 15:39:14 -0500

   On Tue, 2002-11-12 at 12:32, Rusty Russell wrote:
   
   > +static inline char *module_name(struct module *module)
   > +{
   > +	Return "[built-in]";
   > +}
   
   s/Return/return/ ? ;-)
   
I'd rather get a NULL for built-in, honestly.
