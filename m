Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279644AbRKAT6g>; Thu, 1 Nov 2001 14:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279648AbRKAT60>; Thu, 1 Nov 2001 14:58:26 -0500
Received: from wks-40.herta.ronnebyhus.se ([195.17.80.49]:54415 "EHLO
	wks-40.herta.ronnebyhus.se") by vger.kernel.org with ESMTP
	id <S279644AbRKAT6L>; Thu, 1 Nov 2001 14:58:11 -0500
Date: Thu, 1 Nov 2001 20:58:05 +0100 (CET)
From: =?iso-8859-1?Q?Per_Lid=E9n?= <per@fukt.bth.se>
X-X-Sender: per@wks-40.herta.ronnebyhus.se
To: linux-kernel@vger.kernel.org
Subject: Re: on exit xterm  totally wrecks linux 2.4.11 to 2.4.14-pre6
 (unkillable processes)
In-Reply-To: <3BE1A6BF.2010002@softhome.net>
Message-ID: <Pine.LNX.4.40.0111012053370.3889-100000@wks-40.herta.ronnebyhus.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2001, Ricardo Martins wrote:

[...]
> If the problem is with xterm, it sure kicks "Linux Stability" in the
> face. Maybe (and I hope) the problem is in devfs.

xterm is not the problem, it's devfs' locking ema which results in a
deadlock.

/Per

