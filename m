Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbUEaW5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbUEaW5n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 18:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbUEaW5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 18:57:43 -0400
Received: from vsmtp1b.tin.it ([212.216.176.141]:59880 "EHLO vsmtp1.tin.it")
	by vger.kernel.org with ESMTP id S261787AbUEaW5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 18:57:42 -0400
Message-ID: <40BBB861.1010002@stanchina.net>
Date: Tue, 01 Jun 2004 00:57:37 +0200
From: Flavio Stanchina <flavio@stanchina.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: swappiness=0 makes software suspend fail.
References: <200405280000.56742.rob@landley.net> <20040529222308.GA1535@elf.ucw.cz> <20040531031743.0d7566e3.akpm@osdl.org> <200405310638.21015.rob@landley.net>
In-Reply-To: <200405310638.21015.rob@landley.net>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> Of course, mounting/fscking any of the filesystems in question would kinda 
> screw that up too, [...]

That reminds me of a question I wanted to ask for a long time.

Why doesn't suspend just remount everything read-only before saving the
memory image? Would that be impossible in this context? I find it quite
scary to have my filesystems dirty *and* part of my files saved in the
memory image.

-- 
Ciao, Flavio

