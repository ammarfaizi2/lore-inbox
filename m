Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279013AbRKAOWm>; Thu, 1 Nov 2001 09:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279015AbRKAOWd>; Thu, 1 Nov 2001 09:22:33 -0500
Received: from toad.com ([140.174.2.1]:28172 "EHLO toad.com")
	by vger.kernel.org with ESMTP id <S279013AbRKAOWa>;
	Thu, 1 Nov 2001 09:22:30 -0500
Message-ID: <3BE15A85.8B9DF165@mandrakesoft.com>
Date: Thu, 01 Nov 2001 09:21:57 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: driver initialisation order problem
In-Reply-To: <20011101141412.R20398@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:
> 
> drivers/char depends on drivers/parport (lp requires parport)
> drivers/parport depends on drivers/char (parport_serial requires serial)
> 
> How should this dependency be expressed?  The link order of
> drivers/char and drivers/parport isn't enough.

I would move lp to parport, since IMHO it belongs there anyway.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
