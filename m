Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263860AbTKLA2O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 19:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTKLA2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 19:28:14 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:4249 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S263860AbTKLA2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 19:28:13 -0500
Date: Wed, 12 Nov 2003 01:28:11 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: 2 TB partition support
Message-ID: <20031112002811.GA18177@tc.pci.uni-heidelberg.de>
References: <16304.9647.994684.804486@wombat.chubb.wattle.id.au> <HBEHKOEIIJKNLNAMLGAOIECPDKAA.info@avistor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HBEHKOEIIJKNLNAMLGAOIECPDKAA.info@avistor.com>
User-Agent: Mutt/1.5.3i
From: Bernd Schubert <Bernd.Schubert@tc.pci.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 06:12:06PM -0800, Joseph Shamash wrote:
> Hello Peter,
> 
> Forgive another quick Q or two.
> 
> What is the maximum partition size for a patched 2.4.x kernel,
> and where are those patches?
> 

Hello,

Are 2TB possible with an unpatched 2.4.x 64bit-AMD64 kernel? The
partion is supposed to be reiserfs. I read an about 2 years old
discussion about this and Hans Reiser statet that the maximum size is
about 2GB. Unfortunality I don't know what this 'about' depends on.
Furthermore our server for this will be an Opteron and so perhaps this
limit is much higher on 64bit systems.

I really wouldn't like to use the first 2.6.x releases on an important server like this. Also using hardly tested 2.4. patches are not really an option.

Thanks,
	Bernd
