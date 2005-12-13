Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbVLMWY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbVLMWY2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbVLMWY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:24:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56496 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030261AbVLMWY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:24:27 -0500
Date: Tue, 13 Dec 2005 14:24:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ben Gardner <gardner.ben@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: GPIO driver for AMD CS5535/CS5536
Message-Id: <20051213142410.5f5f2bae.akpm@osdl.org>
In-Reply-To: <808c8e9d0512130904j5f202f7cwe0d195efb12afad0@mail.gmail.com>
References: <808c8e9d0512130904j5f202f7cwe0d195efb12afad0@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Gardner <gardner.ben@gmail.com> wrote:
>
>  A simple driver for the CS5535 and CS5536 that allows a user-space
>  program to manipulate GPIO pins.
>  The CS5535/CS5536 chips are Geode processor companion devices.

Should CONFIG_CS5535_GPIO depend on X86 or X86_32?
