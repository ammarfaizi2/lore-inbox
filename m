Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbVKGLmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbVKGLmk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 06:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbVKGLmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 06:42:39 -0500
Received: from [81.2.110.250] ([81.2.110.250]:55998 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S964806AbVKGLmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 06:42:38 -0500
Subject: Re: 2.6.14-mm1 -- undefined reference to `edac_mc_handle_ce'
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Miles Lane <miles.lane@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <a44ae5cd0511062301h7ce185bfk10ac2d92cd20e433@mail.gmail.com>
References: <a44ae5cd0511062301h7ce185bfk10ac2d92cd20e433@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 07 Nov 2005 12:13:13 +0000
Message-Id: <1131365594.11265.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-11-07 at 02:01 -0500, Miles Lane wrote:
> I tried building:
> 
> CONFIG_EDAC=y
> # CONFIG_EDAC_MM_EDAC is not set
> CCONFIG_EDAC_AMD76X=y
> CONFIG_EDAC_POLL=y
> 
> drivers/built-in.o: In function `amd76x_process_error_info':
> : undefined reference to `edac_mc_handle_ce'


Doh, will fix up once I've got synched back with mm1

