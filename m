Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVAXXXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVAXXXx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 18:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVAXXX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:23:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:222 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261630AbVAXXKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 18:10:53 -0500
Date: Mon, 24 Jan 2005 15:10:47 -0800
From: Richard Henderson <rth@redhat.com>
To: Edward Peschko <esp5@pge.com>
Cc: gcc@gcc.gnu.org, libc-alpha@sources.redhat.com,
       binutils@sources.redhat.com, linux-kernel@vger.kernel.org
Subject: Re: forestalling GNU incompatibility - proposal for binary relative dynamic linking
Message-ID: <20050124231047.GC29545@redhat.com>
Mail-Followup-To: Richard Henderson <rth@redhat.com>,
	Edward Peschko <esp5@pge.com>, gcc@gcc.gnu.org,
	libc-alpha@sources.redhat.com, binutils@sources.redhat.com,
	linux-kernel@vger.kernel.org
References: <20050124222449.GB16078@venus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124222449.GB16078@venus>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 02:24:49PM -0800, Edward Peschko wrote:
> What I'd like to do is be able to set up my LD_LIBRARY_PATH 
> so that I can reference it from the point of view of the 
> *executable*:
> 
> 	setenv LD_LIBRARY_PATH   "*/../lib:....."
> 
> Here, read "* == full path of dirname of executable".

See -Wl,-rpath,'$ORIGIN/../lib/'


r~
