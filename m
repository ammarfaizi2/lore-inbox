Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267391AbRGLA5r>; Wed, 11 Jul 2001 20:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267392AbRGLA5h>; Wed, 11 Jul 2001 20:57:37 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:40452 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267391AbRGLA51>; Wed, 11 Jul 2001 20:57:27 -0400
Message-ID: <3B4CF5E8.F9F9C429@transmeta.com>
Date: Wed, 11 Jul 2001 17:57:12 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Rajeev Bector <rajeev_bector@yahoo.com>
CC: linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: Re: new IPC mechanism ideas
In-Reply-To: <20010712005520.20851.qmail@web14402.mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajeev Bector wrote:
> 
> If your driver is in the kernel,
> then you dont need that. All processes
> use system-calls (or ioctls) to send
> messages and when they do recv(),
> they get a pointer to a location
> (where they are mapped to via mmap)
> and they can read directly. In this
> scheme, you dont need any traditional
> UNIX IPC mechanism to work.
> 

And the point of this is?

	-hpa
