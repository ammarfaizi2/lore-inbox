Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261449AbSJQQPk>; Thu, 17 Oct 2002 12:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261519AbSJQQPk>; Thu, 17 Oct 2002 12:15:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42768 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261449AbSJQQPj>;
	Thu, 17 Oct 2002 12:15:39 -0400
Message-ID: <3DAEE378.5050106@pobox.com>
Date: Thu, 17 Oct 2002 12:21:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org, crispin@wirex.com
Subject: Re: [PATCH] make LSM register functions GPLonly exports
References: <20021017153505.A27998@infradead.org> <20021017150740.GA31056@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 03:35:05PM +0100, Christoph Hellwig wrote:
>These exports have the power to change the implementations of all
>syscalls and I've seen people exploiting this "feature".


Ug.  If people are already jumping on this, that might be a good reason 
to revert the entire LSM feature, if EXPORT_SYMBOL_GPL is not acceptable 
to all copyright holders...

Sigh, I hate legal crap.

	Jeff



