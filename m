Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266931AbTGOJNQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 05:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266939AbTGOJNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 05:13:15 -0400
Received: from f17.mail.ru ([194.67.57.47]:61965 "EHLO f17.mail.ru")
	by vger.kernel.org with ESMTP id S266931AbTGOJNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 05:13:14 -0400
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Romano Giannetti=?koi8-r?Q?=22=20?= 
	<romano@dea.icai.upco.es>
Cc: linux-kernel@vger.kernel.org,
       =?koi8-r?Q?=22?=Mark Watts=?koi8-r?Q?=22=20?= 
	<m.watts@eris.qinetiq.com>
Subject: Re: requirements for installing a 2.6.0-test kernel....
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Tue, 15 Jul 2003 13:27:58 +0400
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19cM6I-000NrR-00.arvidjaar-mail-ru@f17.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks, if you want to be on bleeding edge with Mandrake you really
have to read cooker :))

I have put a set of support SRPMs for Mandrake 9.1 on

http://supermount-ng.sf.net/mdk-25/

They currently include initscripts, mkinitrd, module-init-tools and
modultils. I had devfsd and gkrellm as well but now they are
incorporated into mainstream, just fetch them from cooker.

Using these packages I freely switch between 2.4 and 2.6 on the same
Mandrake 9.1 based box. Actually the reason I made them was exactly
this - I needed abililty to work normally on supermount for 2.6 :)

They are fully modules-enabled, actually my config is basically
Mandrake default with obvious 2.6 modifications (I made it more and
more modular with the time), initrd, devfs etc are supported.

module-init-tools will try to build modprobe.conf from your modules.conf and include suitable /etc/modprobe.devfs; also I have
packaged default module aliases.

I really need feedback with them - they work for me but other people
had issues with module autoloading.

I will update them every now and then for new Mandrake packages.

regards

-andrey

>On Mon, Jul 14, 2003 at 06:17:07PM +0100, Mark Watts wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>> 
>> 
>> Sure - I'm trying it on Mandrake 9.1
>> 
>> I've already had fun with the module_init_tools from 
>> http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
>> 
>> Basically after doing the ./configure --prefix=/ && make moveold, I was left 
>> with a bunch of dangling symlinks in /sbin
>> 
>> I've since grabed the src.rpm from here: 
>> http://people.redhat.com/arjanv/2.5/SRPMS/
>> and that seems to be behaving a bit more (although I haven't rebooted yet :)
>> 
>> Everything else is from a standard Mandrake 9.1 install, so I'm using gcc 
>> 3.2.2 and associated gubbins.
>> 

> I'm also interested (I have a mdk 9.1 installed, too), so please keep us
> informed. I would like to test 2.6, but I have to do real work too, so I
> need the ability to switch back safely to a 2.4 kernel... so if you succeed,
> please share! Thanks a lot! 


