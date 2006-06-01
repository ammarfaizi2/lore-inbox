Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbWFAUGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbWFAUGL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 16:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWFAUGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 16:06:11 -0400
Received: from gw.openss7.com ([142.179.199.224]:37044 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S1030263AbWFAUGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 16:06:09 -0400
Date: Thu, 1 Jun 2006 14:06:07 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Bob Picco <bob.picco@hp.com>
Cc: hpa@zytor.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] klibc
Message-ID: <20060601140607.A1688@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Bob Picco <bob.picco@hp.com>, hpa@zytor.com,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20060601194751.GD17809@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060601194751.GD17809@localhost>; from bob.picco@hp.com on Thu, Jun 01, 2006 at 03:47:51PM -0400
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2006, Bob Picco wrote:
>  
> -#if !defined(__x86_64__) && !defined(__ia64__) && !defined(__sparc_v9__)
> +#if !defined(__x86_64__) && !defined(__ia64__) && !defined(__sparc_v9__) && \
> +	!defined(__powerpc64__)

Why not just !defined(__LP64__) ?

