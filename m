Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbTAJJnZ>; Fri, 10 Jan 2003 04:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264739AbTAJJnZ>; Fri, 10 Jan 2003 04:43:25 -0500
Received: from are.twiddle.net ([64.81.246.98]:41091 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S264724AbTAJJnZ>;
	Fri, 10 Jan 2003 04:43:25 -0500
Date: Fri, 10 Jan 2003 01:52:03 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Miles Bader <miles@gnu.org>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] Make `obsolete params' work correctly if MODULE_SYMBOL_PREFIX is non-empty
Message-ID: <20030110015203.A16268@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Miles Bader <miles@gnu.org>, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <20030107063239.F1ED73745@mcspd15.ucom.lsi.nec.co.jp> <20030110073328.D41A52C310@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030110073328.D41A52C310@lists.samba.org>; from rusty@rustcorp.com.au on Wed, Jan 08, 2003 at 10:56:51PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 10:56:51PM +1100, Rusty Russell wrote:
> +		char sym_name[strlen(obsparm[i].name) + 2];

Are you really intending to use variable sized allocation
on the kernel stack?


r~
