Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266638AbTABWrV>; Thu, 2 Jan 2003 17:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266652AbTABWrV>; Thu, 2 Jan 2003 17:47:21 -0500
Received: from are.twiddle.net ([64.81.246.98]:25220 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S266638AbTABWrU>;
	Thu, 2 Jan 2003 17:47:20 -0500
Date: Thu, 2 Jan 2003 14:54:36 -0800
From: Richard Henderson <rth@twiddle.net>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.54 kill module.h compiler warnings
Message-ID: <20030102145436.C20498@twiddle.net>
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
References: <200301021557.QAA06497@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301021557.QAA06497@harpo.it.uu.se>; from mikpe@csd.uu.se on Thu, Jan 02, 2003 at 04:57:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 04:57:19PM +0100, Mikael Pettersson wrote:
> The patch below silences the warnings by adding back the
> missing (void) casts. Works for me.

Better to make try_module_get a real inline function.


r~
