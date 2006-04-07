Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbWDGUr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbWDGUr4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 16:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWDGUr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 16:47:56 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:35484 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964950AbWDGUr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 16:47:56 -0400
Date: Fri, 7 Apr 2006 22:47:31 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: John Rigby <jcrigby@gmail.com>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow menuconfig to cycle through choices
In-Reply-To: <4b73d43f0604061754j7a6e5dccu1d9af4b3167e9758@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0604072244420.32445@scrub.home>
References: <4b73d43f0604061338i1c5315f1t34761380b620fc57@mail.gmail.com> 
 <4b73d43f0604061339n35a4d98ha08bf8d7fc0bef0b@mail.gmail.com> 
 <4b73d43f0604061358v1c619e21rc6f3af2cdc4545a3@mail.gmail.com> 
 <20060406154040.c5430029.rdunlap@xenotime.net>  <20060406160455.0f0eabee.rdunlap@xenotime.net>
 <4b73d43f0604061754j7a6e5dccu1d9af4b3167e9758@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 6 Apr 2006, John Rigby wrote:

> If you have multiple configs inside a choice with prompts that start with the
> same character typing the first character takes you to the first one under
> the old behavior.  You have to use arrow or +/- keys to go to the other choices.
> 
> With the patch typing the first character will cycle between all the
> prompts starting
> with that character.
> 
> This behavior is always been available in normal "menus" which are handled by
> dialog_menu.  This patch adds the same functionality to dialog_checklist.

Could you add this information to the patch description? It had me a 
little confused too, what the patch actually does, otherwise:

Acked-by: Roman Zippel <zippel@linux-m68k.org>

bye, Roman
