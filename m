Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267823AbUIVVGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267823AbUIVVGj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 17:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267882AbUIVVGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 17:06:38 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:2052 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S267823AbUIVVGf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 17:06:35 -0400
In-Reply-To: <4151E749.7060107@skynet.be>
References: <4151E749.7060107@skynet.be>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <47612A96-0CDB-11D9-BC62-000D9352858E@linuxmail.org>
Content-Transfer-Encoding: 8BIT
Cc: linux-kernel@vger.kernel.org
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: 2.6.x ( unable to open an initial console & unable to mount devfs, err: -5 ) 
Date: Wed, 22 Sep 2004 23:06:31 +0200
To: Madnux <madnux@skynet.be>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 22, 2004, at 22:57, Madnux wrote:

> Hello,
>
>
> I have some problems with my kernel 2.6.7 and 2.6.8.1.
>
> I get this message « mount_devfs_fs(): unable to mount devfs, err: -5 
> » and then « unable to open an initial console » What's this ? What 
> does « err: -5 » mean ?
>
> I tried with no devfs compiled in but i still have this error message 
> « unable to open an initial console »
>
> Fortunatly, i had kept my old kernel ( 2.4.20 ) who have no devfs 
> compiled in and it run very well for 7 months ;-)
>
>
> What's wrong with my system ?? Did i forget an option in the 
> compilation ?
>
>
> I have looked everywhere about that problem until monday !

I think you are running one of the latest udev snapshots from RawHide, 
and it erased some important device nodes from your "/dev" directory. I 
guess you'll need to run /sbin/makedev to recreate the missing devices 
files.
