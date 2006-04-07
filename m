Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWDGHUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWDGHUt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 03:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWDGHUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 03:20:48 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:47883 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932321AbWDGHUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 03:20:48 -0400
Date: Fri, 7 Apr 2006 09:20:45 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Ram <vshrirama@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Preprocessing output of kernel sources
Message-ID: <20060407072045.GA994@mars.ravnborg.org>
References: <8bf247760604062340m7b83f0bbpe90a9222709a3a5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bf247760604062340m7b83f0bbpe90a9222709a3a5e@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2006 at 11:40:38PM -0700, Ram wrote:
> Hi,
> What is the best way to let C preprocessor to parse all the
> kernel source files to resolve #ifdef's after I have configured the
> kernel?
make dir/file.i is your friend.
It will preprocess the specified file with relevant options.

	Sam
