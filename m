Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbUK3Tz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbUK3Tz0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 14:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbUK3TxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:53:06 -0500
Received: from cpc5-hem13-6-0-cust134.lutn.cable.ntl.com ([82.6.21.134]:31996
	"EHLO arkady.demon.co.uk") by vger.kernel.org with ESMTP
	id S262278AbUK3TqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:46:01 -0500
Message-ID: <41ACCDF6.5060307@ntlworld.com>
Date: Tue, 30 Nov 2004 19:45:58 +0000
From: Bernard Hatt <bernard.hatt@ntlworld.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Yet another filesystem - sffs
References: <41AC2DBE.1080501@ntlworld.com> <cohlov$s7p$1@news.cistron.nl>
In-Reply-To: <cohlov$s7p$1@news.cistron.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:
> I've been using such a filesystem for years, since Linux 2.0 ..
> It's at ftp://ftp.cistron.nl/pub/people/miquels/kernel/v2.[0246]/rawfs-*

> Mike.

Yes, it depends how much functionality you *need*, sffs implements
more file operations so that you can do things like:
	mkisofs -o /mnt/test/blah.iso  [...]
and	cdrecord -v -data /mnt/test/blah.iso (without needing isosize).

But what is odd, having run my benchmarks on rawfs, that sffs
is faster by between (0.5% and 4.6%) where I was expecting
almost identical results (but then, benchmarks aren't everything).

Regards,

Bernard
