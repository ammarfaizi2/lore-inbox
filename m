Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263008AbTJUAJo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 20:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263061AbTJUAJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 20:09:43 -0400
Received: from [65.172.181.6] ([65.172.181.6]:52186 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263008AbTJUAIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 20:08:25 -0400
Date: Mon, 20 Oct 2003 17:08:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: ranty@debian.org
Cc: hunold@convergence.de, marcel@holtmann.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Proposal to remove workqueue usage from
 request_firmware_async()
Message-Id: <20031020170804.2117d9ca.akpm@osdl.org>
In-Reply-To: <20031020235355.GA3068@ranty.pantax.net>
References: <20031020235355.GA3068@ranty.pantax.net>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manuel Estrada Sainz <ranty@debian.org> wrote:
>
>  How does this look?

OK I guess.  I assume it works?

> +	daemonize("%s/%s", "firmware", fw_work->name);

	daemonize("firmware/%s", "fw_work->name);

