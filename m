Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270620AbTG0JhC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 05:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270700AbTG0JhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 05:37:02 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:51421 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S270620AbTG0JhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 05:37:01 -0400
Date: Sun, 27 Jul 2003 11:51:58 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Bernardo Innocenti <bernie@develer.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make I/O schedulers optional
Message-ID: <20030727095158.GE17724@louise.pinerecords.com>
References: <200307270319.04168.bernie@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307270319.04168.bernie@develer.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [bernie@develer.com]
> 
> +config IOSCHED_AS
> +	bool "Anticipatory I/O scheduler" if EMBEDDED
> +	default y
> +
> +config IOSCHED_DEADLINE
> +	bool "Deadline I/O scheduler" if EMBEDDED
> +	default y

Please provide the help entries too.

-- 
Tomas Szepe <szepe@pinerecords.com>
