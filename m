Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVEFCoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVEFCoU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 22:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVEFCoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 22:44:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:54660 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262179AbVEFCoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 22:44:18 -0400
Date: Thu, 5 May 2005 19:43:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: hubert.tonneau@fullpliant.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3 fails to read partition table
Message-Id: <20050505194342.5ecde856.akpm@osdl.org>
In-Reply-To: <20050505161610.GA4604@pclin040.win.tue.nl>
References: <055UDZ711@server5.heliogroup.fr>
	<20050505161610.GA4604@pclin040.win.tue.nl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> wrote:
>
> Earlier Linux disregarded partition types, today 0 means "unused".

A number of people are being bitten by this.  Don't you think we should
revert this change?  
