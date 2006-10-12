Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWJLWsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWJLWsN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 18:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWJLWsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 18:48:12 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:50895 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751274AbWJLWsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 18:48:11 -0400
From: Roman Zippel <zippel@linux-m68k.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: [PATCH] Redefine instances of sema_init() to use standard form.
Date: Fri, 13 Oct 2006 00:47:58 +0200
User-Agent: KMail/1.9.4
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0610120330540.5013@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0610120330540.5013@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610130047.58507.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 12 October 2006 09:44, Robert P. J. Day wrote:

> Since there seems to be no compelling reason *not* to do this, 
[..]
> -	/*
> -	 * Logically,
> -	 *   *sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
> -	 * except that gcc produces better initializing by parts yet.
> -	 */

You've seen this?

bye, Roman
