Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbUJYTBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbUJYTBD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 15:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbUJYS7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 14:59:52 -0400
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:47626 "EHLO
	smtp-vbr13.xs4all.nl") by vger.kernel.org with ESMTP
	id S261220AbUJYS6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 14:58:00 -0400
From: Nico Augustijn <kernel@janestarz.com>
To: Valdis.Kletnieks@vt.edu
Subject: Re: Cryptoloop patch for builtin default passphrase
Date: Mon, 25 Oct 2004 20:57:57 +0200
User-Agent: KMail/1.7.1
References: <200410251354.31226.kernel@janestarz.com> <200410251719.i9PHJmOi009687@turing-police.cc.vt.edu>
In-Reply-To: <200410251719.i9PHJmOi009687@turing-police.cc.vt.edu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410252057.58151.kernel@janestarz.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 October 2004 19:19, you wrote:
> On Mon, 25 Oct 2004 13:54:31 +0200, "Nico Augustijn." said:
> > But all that takes some searching. And the passphrase is also XOR-ed with
> > the first 32 bytes of /dev/nvram.
>
> So if something touches the first 32 bytes of NVRAM, your data evaporates?
>
> Is this considered a desirable result?
Yes. In this case it is very much a desirable result.
As this patch is meant (as far as I am concerned) for embedded systems only, I 
really don't want people to muck about with the BIOS settings (primary boot 
device, for instance).
