Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWCMXJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWCMXJK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 18:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWCMXJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 18:09:10 -0500
Received: from ns.firmix.at ([62.141.48.66]:49584 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S932243AbWCMXJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 18:09:08 -0500
Subject: Re: [future of drivers?] a proposal for binary drivers.
From: Bernd Petrovitsch <bernd@firmix.at>
To: Anshuman Gholap <anshu.pg@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jan Knutar <jk-lkml@sci.fi>
In-Reply-To: <ec92bc30603080203rb4f5e7bvea993a44ceb5d3ca@mail.gmail.com>
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com>
	 <200603081151.33349.jk-lkml@sci.fi>
	 <ec92bc30603080203rb4f5e7bvea993a44ceb5d3ca@mail.gmail.com>
Content-Type: text/plain
Organization: http://www.firmix.at/
Date: Tue, 14 Mar 2006 00:06:48 +0100
Message-Id: <1142291208.8407.46.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 15:33 +0530, Anshuman Gholap wrote:
[...]
> into installing it) , he knowing me as a linux person will keep
> bugging me, when i tell him to install a kernel source compile it to
> allow 16k stack, install ndiswrapper and load the windows driver and

And you seriously think that $COMPANY will rewrite their driver to work
with 4K-stacks (which seems to me to be an absolute requirement ATM)?

[...]
> if there was binary allowed (with any license) maybe dlink themself
> would build a driver, make documentation and provide it on CD, just

Here are too many "maybe"s and "would" in there. Do you have a written
contract or similar stuff?

And who is maintaining that driver and solving all possibly related
problems?
It is not fun to debug software where some unknown piece of code may
have introduced a bug and you can't chase it down since you don't have
the source.
Will $COMPANY have enough capable people to follow LKML and look after
bug reports involving their driver as long as the driver should be
considered maintained?
Will $COMPANY provide versions for not-Intel CPUs where people may put
their hardware into?

The trivial solution is: Don't buy that hardware if you want to run it
on Linux.

Alas, the big difference is: In the Windows world, the hardware
companies are interested to solve problems with their drivers (otherwise
they have no business), in the Linux world they are not.
And that won't change with "officially" allowing binary drivers.

The consequence would be that $COMPANY writes a driver and blames the
rest of the Linux world to change some internal undocumented interface
months lateron just that they can commercially state to "support Linux"
but without any real reason. In the non-evolutionary Windows world this
holds until the next major release, but not on the high-tech front.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services



