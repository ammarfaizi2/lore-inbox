Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVGGM3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVGGM3d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 08:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVGGM3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 08:29:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28808 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261435AbVGGM1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 08:27:55 -0400
Date: Thu, 7 Jul 2005 08:27:48 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: raja <vnagaraju@effigent.net>, linux-kernel@vger.kernel.org
Subject: Re: ipc
Message-ID: <20050707122747.GR3720@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <42CD12A7.90106@effigent.net> <20050707141302.1f40eb89@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707141302.1f40eb89@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 02:13:02PM +0200, Paolo Ornati wrote:
> You need to tell GCC to use "libmqueue"... something like this:
> 
> 	gcc -Wall -O2 -o prog prog.c -lmqueue

If you have glibc 2.3.4 or later, you should use -lrt instead.

	Jakub
