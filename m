Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282874AbRK0Iaf>; Tue, 27 Nov 2001 03:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282868AbRK0Ia0>; Tue, 27 Nov 2001 03:30:26 -0500
Received: from [213.237.118.153] ([213.237.118.153]:8320 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S282873AbRK0IaK>;
	Tue, 27 Nov 2001 03:30:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Allan Sandfeld <linux@sneulv.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: Release Policy [was: Linux 2.4.16  ]
Date: Tue, 27 Nov 2001 09:28:50 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.40.0111261216500.88-100000@rc.priv.hereintown.net> <20011126161802.A8398@xi.linuxpower.cx> <3C034889.6040000@oracle.com>
In-Reply-To: <3C034889.6040000@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E168dbm-0000Jr-00@Princess>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 November 2001 09:02, Svein Erik Brostigen wrote:
>
> What really scares me is not so much the way the kernels are numbered as
> the way features gets added to
> the kernels.
> Internally in Oracle we do not add new features to a release number,
> just bug-fixes.
> Hence 2.4.0 is the base release of the 2.4.x kernel series. the minor
> x-number should just indicate a bug-fix
> release. Thus, no new features should get added to the 2.4 kernel with
> this numbering schema.
> If you really want to add features into the 2.4.x kernel, you also need
> to extend the numbering schema.
> I.e 2.4.0.x wil then be the bug-fix releases and  2.4.1.x will have new
> features.
> This makes it easier to maintain and to understand what is happening
> between the various releases.
>
> As far as I can understand, today, new features are added to a released
> kernel without any sensible numbering scheme
> identifying this fact. I don't know if a 2.4.10 kernel contains the same
> features as 2.4.16 with the only difference beeing bug-fixes
> or if there have been added new features. By using a numbering scheme
> that is consistent across both development and
> production kernels, it is easier to identify the features in a kernel.
>
The problem is that for kernels new features _are_ bug-fixes. Like the new 
vm, work-around for discovered bugs in hardware, etc., etc. 
I an way what should't be done in a -rc release is new fixing features, but 
only the fixing _of_ features. ;-)

