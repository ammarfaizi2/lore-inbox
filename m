Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbVC2Bg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVC2Bg4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 20:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbVC2Bgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 20:36:55 -0500
Received: from fire.osdl.org ([65.172.181.4]:57512 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262141AbVC2Bgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 20:36:48 -0500
Date: Mon, 28 Mar 2005 17:33:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] always enable regparm on i386
Message-Id: <20050328173325.72323e3c.akpm@osdl.org>
In-Reply-To: <20050327202116.GP4285@stusta.de>
References: <20050327202116.GP4285@stusta.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
>  The patch below always enables regparm on i386 (with gcc >= 3.0).

I'd prefer to keep the config option so that people can diagnose compiler
and kernel bugs by disabling it.  This has proved useful in the past.

