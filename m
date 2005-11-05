Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbVKED2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbVKED2t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 22:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbVKED2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 22:28:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13968 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751157AbVKED2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 22:28:49 -0500
Date: Fri, 4 Nov 2005 19:28:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] sh: SuperHyway support for SH4-202.
Message-Id: <20051104192840.395d1503.akpm@osdl.org>
In-Reply-To: <20051102223118.GD27200@linux-sh.org>
References: <20051102223118.GD27200@linux-sh.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mundt <lethal@linux-sh.org> wrote:
>
> +int __init superhyway_scan_bus(struct superhyway_bus *bus)

This appears to be unreferenced, and perhaps doesn't need global scope?
