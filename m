Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264388AbUHBWoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbUHBWoR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 18:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUHBWoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 18:44:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:33197 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264388AbUHBWoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 18:44:07 -0400
Date: Mon, 2 Aug 2004 15:43:08 -0700
From: Greg KH <greg@kroah.com>
To: maximilian attems <janitor@sternwelten.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch-kj] use list_for_each() i386/pci/pcbios.c
Message-ID: <20040802224308.GH15303@kroah.com>
References: <20040723091916.GC14000@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040723091916.GC14000@stro.at>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2004 at 11:19:16AM +0200, maximilian attems wrote:
> 
> Use list_for_each() where applicable
> - for (list = ymf_devs.next; list != &ymf_devs; list = list->next) {
> + list_for_each(list, &ymf_devs) {
> pure cosmetic change, defined as a preprocessor macro in:
> include/linux/list.h
> 
> patch against 2.6.7-bk20, please tell if you need against newer.
> 
> From: Domen Puncer <domen@coderock.org>
> Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

Applied, thanks.

greg k-h
