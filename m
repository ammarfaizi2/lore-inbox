Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265314AbUGAODn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265314AbUGAODn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 10:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbUGAODm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 10:03:42 -0400
Received: from linux2.isphuset.no ([213.236.237.186]:1161 "EHLO
	gtw.mailserveren.com") by vger.kernel.org with ESMTP
	id S265314AbUGANzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 09:55:12 -0400
Subject: Re: ACPI / cpu temperature problem
From: Hans Kristian Rosbach <hans.kristian@isphuset.no>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1087561770.8257.6.camel@linux.local>
References: <1086783539.14784.24.camel@linux.local>
	 <1087561770.8257.6.camel@linux.local>
Content-Type: text/plain
Organization: ISPHuset Nordic AS
Message-Id: <1088690104.4204.88.camel@linux.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 01 Jul 2004 15:55:04 +0200
Content-Transfer-Encoding: 7bit
X-Declude-Sender: hans.kristian@isphuset.no [195.159.151.115]
X-Note: This E-mail was scanned by Declude JunkMail (www.declude.com) for spam.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Now, the problem with all these supermicro servers is that the
> > temperature seems to be stuck at 27 C. No matter what load or
> > temperature in the room. Something is clearly wrong.
> > What can be done to fix this? We tried setting polling_frequency
> > to '10', but that made no difference.
> 
> I reported this to the kernel bug tracker, but there seems to be
> no forward movement at all. So I'll try here again in the hope that
> someone that know this code atleast has a comment to it.
> 
> http://bugme.osdl.org/show_bug.cgi?id=2855


With some help from the very nice and efficent (!!) guys at Supermicro,
the problem has been resolved in bios for now by removing the cpu
temperature feature. This atleast solves the problem for us, since it
now no longer advertises a fake temperature.

The board P4SCE/P4SCA bios version 1.2c (or higher) will soon be
released
officially with this bugfix.

Hopefully they will include support for actual temperature readout at
some time.

Supermicro staff: Thank you =)


Sincerly
    Hans K. Rosbach



