Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbWH2Ngs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWH2Ngs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 09:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWH2Ngs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 09:36:48 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:51687 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S964967AbWH2Ngr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 09:36:47 -0400
Date: Tue, 29 Aug 2006 15:37:00 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm3
Message-ID: <20060829153700.309334d6@cad-250-152.norway.atmel.com>
In-Reply-To: <20060826160922.3324a707.akpm@osdl.org>
References: <20060826160922.3324a707.akpm@osdl.org>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Aug 2006 16:09:22 -0700
Andrew Morton <akpm@osdl.org> wrote:

> +namespaces-add-nsproxy-move-init_nsproxy-into-kernel-nsproxyc.patch

This causes a multiple definition of init_nsproxy on AVR32. Reverting
namespaces-add-nsproxy-avr32-fix.patch fixes it.

Haavard
