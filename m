Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWBRQVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWBRQVU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 11:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWBRQVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 11:21:20 -0500
Received: from ms-smtp-01-smtplb.tampabay.rr.com ([65.32.5.131]:62629 "EHLO
	ms-smtp-01.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751416AbWBRQVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 11:21:20 -0500
Message-ID: <43F74969.2010500@cfl.rr.com>
Date: Sat, 18 Feb 2006 11:20:57 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: Marcin Dalecki <dalecki.marcin@neostrada.pl>
CC: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: C/H/S from user space
References: <Pine.LNX.4.61.0602171157140.8950@chaos.analogic.com> <43F617FA.2030609@wolfmountaingroup.com> <Pine.LNX.4.61.0602171452520.4290@chaos.analogic.com> <43F63A59.6090401@cfl.rr.com> <Pine.LNX.4.61.0602171609480.4549@chaos.analogic.com> <43F64C2F.7040200@cfl <66D6145F-E9F9-4B4F-B06F-3C40018E8F86@neostrada.pl>
In-Reply-To: <66D6145F-E9F9-4B4F-B06F-3C40018E8F86@neostrada.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcin Dalecki wrote:
> It has been already tried years ago to eliminate this ridicle. The 
> answer to your
> question is put bluntly: It's like that, because some kernel "prima 
> ballerinas",
> whose names "relate to alternating current", will get at you with mock 
> up somke
> and mirror woodo examples where it's supposed to be sooo required.

I myself have been trying to show why it is required.  Unless I am wrong 
about the msdos MBR code passing the CHS partition start values directly 
to int 13 rather than computing them based on the LBA in the MBR and the 
currently reported geometry from the bios, then fdisk does require the 
correct bios geometry to maintain compatibility with msdos/windows.


My original point was that if it is required ( and since it is still in 
the kernel, that seems to be the case ) then at least make sure it is 
_correct_.  Whether it is needed but wrong, or if it is simply not 
needed, then it is silly to keep geometry in the kernel.

