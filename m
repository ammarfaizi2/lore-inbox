Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967744AbWLEXXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967744AbWLEXXU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 18:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967745AbWLEXXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 18:23:19 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:23107 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967744AbWLEXXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 18:23:17 -0500
Date: Wed, 6 Dec 2006 00:23:02 +0100 (MET)
From: Olaf Hering <olaf@aepfle.de>
To: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
Cc: linux-kernel@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 0/3] New firewire stack
Message-ID: <20061205232154.GA14340@aepfle.de>
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, Kristian Høgsberg wrote:

> I'm announcing an alternative firewire stack that I've been working on

I suggest you hash out the most obvious bugs in -mm.
Once it you have it in a reasonable shape, replace the drivers in
drivers/ieee1394 in one go.
Its just not worth the pain to switch from module a.ko to module b.ko,
keep the name a.ko because its the very same functionality after all.
