Return-Path: <linux-kernel-owner+w=401wt.eu-S1030282AbWLTTGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWLTTGc (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 14:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbWLTTGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 14:06:31 -0500
Received: from lazybastard.de ([212.112.238.170]:38363 "EHLO
	longford.lazybastard.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030282AbWLTTGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 14:06:31 -0500
Date: Wed, 20 Dec 2006 19:03:38 +0000
From: =?utf-8?B?SsO2cm4=?= Engel <joern@lazybastard.org>
To: Yakov Lerner <iler.ml@gmail.com>
Cc: Kernel <linux-kernel@vger.kernel.org>
Subject: Re: two architectures,same source tree
Message-ID: <20061220190338.GA13966@lazybastard.org>
References: <f36b08ee0612201032m54956e7ay35ca5f63a65e788f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f36b08ee0612201032m54956e7ay35ca5f63a65e788f@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 December 2006 20:32:20 +0200, Yakov Lerner wrote:
> 
> Is it easily possible to build two architectures in
> the same source tree (so that intermediate fles
> and resut files do not interfere ) ?

I'd try something like this:
make O=../foo ARCH=foo
make O=../bar ARCH=bar

But as I'm lazy I'll leave the debugging to you. :)

Jörn

-- 
Linux [...] existed just for discussion between people who wanted
to show off how geeky they were.
-- Rob Enderle
