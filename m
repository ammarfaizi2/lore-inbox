Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWDJJfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWDJJfM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 05:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWDJJfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 05:35:12 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:58288 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751092AbWDJJfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 05:35:10 -0400
Date: Mon, 10 Apr 2006 11:35:07 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [PATCH 0/19] kconfig patches
In-Reply-To: <20060410005153.2a5c19e2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604101122530.32445@scrub.home>
References: <Pine.LNX.4.64.0604091628240.21970@scrub.home>
 <20060409235548.52b563a9.akpm@osdl.org> <Pine.LNX.4.64.0604101035240.32445@scrub.home>
 <20060410005153.2a5c19e2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 10 Apr 2006, Andrew Morton wrote:

> > If you call "make oldconfig", you have to restore the symlink manually.
> 
> Why?  What advantage does that have?
> 
> I've been using the copy-it-there approach for maybe four years and have
> yet to notice any problem with it.

Pretty much every other tool removes the old file before or after creating 
the new file. This allows it to work with a hardlinked tree, which 
unfortunately is currently broken for other reasons in kbuild.

Could you send me link or a copy of your build tools, which deals with the 
symlink?

bye, Roman
