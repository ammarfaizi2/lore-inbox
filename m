Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbWFHUco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWFHUco (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 16:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWFHUcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 16:32:43 -0400
Received: from main.gmane.org ([80.91.229.2]:65414 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964982AbWFHUcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 16:32:43 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: booting without initrd
Date: Thu, 08 Jun 2006 21:32:03 +0100
Message-ID: <yw1xlks7e6d8.fsf@agrajag.inprovide.com>
References: <728201270606070913g2a6b23bbj9439168a1d8dbca8@mail.gmail.com> <b29067a0606081040q17c66f5bpa966da851635e942@mail.gmail.com> <4488368B.5070103@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: agrajag.inprovide.com
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through Obscurity, linux)
Cancel-Lock: sha1:pEmaCn6hqaQoF01TYs4seXJhyBw=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord <lkml@rtr.ca> writes:

> Rahul Karnik wrote:
>>
>> AFAIK Fedora sets up the kernel command line with "root=LABEL=/" in
>> grub.conf and therefore needs the initrd in order to work correctly.
>> If you do not want an initrd, then change this to
>> "root=/dev/<your_disk>" in grub.conf. Note that the reason Fedora uses
>> the LABEL is so you can move disks around in your system without a problem
>
> Heh.. except for people like me, who regularly swap disks around
> to boot from different distros, in which case the LABEL=/ continuously
> causes nothing but grief until I remember to edit it away.

Yes, there's an old saying that "grief comes with a red hat".

-- 
Måns Rullgård
mru@inprovide.com

