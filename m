Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWFTJHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWFTJHT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 05:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbWFTJHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 05:07:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49059 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030187AbWFTJHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 05:07:17 -0400
Date: Tue, 20 Jun 2006 02:07:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] Clear abnormal poweroff flag on VIA southbridges, fix
 resume
Message-Id: <20060620020713.84bddbb4.akpm@osdl.org>
In-Reply-To: <20060620085429.GB27362@srcf.ucam.org>
References: <20060618191421.GA15358@srcf.ucam.org>
	<20060619230144.155bc938.akpm@osdl.org>
	<20060620085429.GB27362@srcf.ucam.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 09:54:29 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> CONFIG_ACPI_SLEEP might be a better choice than CONFIG_ACPI, 
> yes.

OK, I diddled the diff to use CONFIG_ACPI_SLEEP, thanks.
