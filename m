Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289293AbSBDXhQ>; Mon, 4 Feb 2002 18:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289294AbSBDXg4>; Mon, 4 Feb 2002 18:36:56 -0500
Received: from ua0d5hel.dial.kolumbus.fi ([62.248.132.0]:65085 "EHLO
	porkkala.uworld.dyndns.org") by vger.kernel.org with ESMTP
	id <S289293AbSBDXgu>; Mon, 4 Feb 2002 18:36:50 -0500
Message-ID: <3C5F1B0A.DD38E4D0@kolumbus.fi>
Date: Tue, 05 Feb 2002 01:36:42 +0200
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
In-Reply-To: <Pine.LNX.4.33.0202050157170.19749-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> Please renice your CPU hog soundcard processes to -11, does that make any
> difference? (under -K2)

I can renice this only for testing purposes. Normally these are not run as
root so I can't do negative renice.
 
> is it more important to run these CPU hogs than to run interactive tasks?
> If yes then renice them to -11.

Yes and no... :) Interactive tasks get their work from CPU hogs so those are
strongly related. If interactive task puts CPU hog to wait it will also lose
it's data.


	- Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

