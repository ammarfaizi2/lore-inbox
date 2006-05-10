Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbWEJO4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWEJO4s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 10:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWEJO4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 10:56:48 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16352 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964967AbWEJO4r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 10:56:47 -0400
Subject: Re: [PATCH -mm] megaraid gcc 4.1 warning fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, Seokmann.Ju@lsil.com, linux-kernel@vger.kernel.org
In-Reply-To: <1147270874.21536.66.camel@c-67-180-134-207.hsd1.ca.comcast.net>
References: <200605100256.k4A2u3lB031731@dwalker1.mvista.com>
	 <1147257558.17886.8.camel@localhost.localdomain>
	 <1147270874.21536.66.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 10 May 2006 16:08:39 +0100
Message-Id: <1147273719.17886.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-05-10 at 07:21 -0700, Daniel Walker wrote:
> The writel on 1153 is attached to a memory leak, or I add one in this
> patch ?

You exit without cleaning up.

