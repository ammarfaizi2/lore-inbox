Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbVHZSTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbVHZSTx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 14:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbVHZSTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 14:19:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4553 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965143AbVHZSTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 14:19:52 -0400
Date: Fri, 26 Aug 2005 11:18:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Robert Love <rml@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] IBM HDAPS accelerometer driver.
Message-Id: <20050826111821.5f0cf386.akpm@osdl.org>
In-Reply-To: <1125069494.18155.27.camel@betsy>
References: <1125069494.18155.27.camel@betsy>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@novell.com> wrote:
>
> +config SENSORS_HDAPS
>  +	tristate "IBM Hard Drive Active Protection System (hdaps)"
>  +	depends on HWMON
>  +	default n
>  +	help

How does this get along with CONFIG_INPUT=n, CONFIG_INPUT_MOUSEDEV=n, etc?
