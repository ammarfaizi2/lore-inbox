Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbTAaPgm>; Fri, 31 Jan 2003 10:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbTAaPgm>; Fri, 31 Jan 2003 10:36:42 -0500
Received: from dark.pcgames.pl ([195.205.62.2]:10911 "EHLO dark.pcgames.pl")
	by vger.kernel.org with ESMTP id <S261426AbTAaPgl> convert rfc822-to-8bit;
	Fri, 31 Jan 2003 10:36:41 -0500
Date: Fri, 31 Jan 2003 16:45:56 +0100 (CET)
From: =?ISO-8859-2?Q?Krzysztof_Ol=EAdzki?= <ole@ans.pl>
X-X-Sender: <ole@dark.pcgames.pl>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Default mount options ignored on ext3
In-Reply-To: <200301311637.23190.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.33.0301311640560.24196-100000@dark.pcgames.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 31 Jan 2003, Marc-Christian Petersen wrote:

> On Friday 31 January 2003 15:18, Krzysztof Olêdzki wrote:
>
> Hi Krzysztof,
>
> > It seems that "Default mount options" from ext3 fs is ignored by
> > the linux kernel. I have just set "Default mount options" to
> > "journal_data" on my root fs but kernel still mounts it with
> > journal_data_ordered:
> I am pretty sure you didn't try "append=rootflags=data=journal" did you? :)

Yes. This is true. But if I have to set rootflags= I can't find any reason
for allowing to change "Default mount options". Kernel ignores it, mount
ignores it... Hm....

Best Regards,

			Krzysztof Oledzki

