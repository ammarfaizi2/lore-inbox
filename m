Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291233AbSBLW6F>; Tue, 12 Feb 2002 17:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291235AbSBLW5z>; Tue, 12 Feb 2002 17:57:55 -0500
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:50693 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S291233AbSBLW5t>;
	Tue, 12 Feb 2002 17:57:49 -0500
Date: Tue, 12 Feb 2002 17:57:45 -0500 (EST)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: Rob Landley <landley@trommello.org>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: small IDE cleanup: void * should not be used unless neccessary
In-Reply-To: <20020212224930.OKGN9845.femail25.sdc1.sfba.home.com@there>
Message-ID: <Pine.LNX.4.33.0202121757080.26027-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Feb 2002, Rob Landley wrote:

> Now I'm confused about the comment on the end of the line.
>
> Should the comment be changed, or should the type be ide_hwgroup_t instead of
> struct hwgroup_s?
>
> Rob

the ide_hwgroup_t typedef is not declared until later in ide.h

Regards,
Rob Radez

