Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261576AbRE0TQh>; Sun, 27 May 2001 15:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261577AbRE0TQ1>; Sun, 27 May 2001 15:16:27 -0400
Received: from smtp2.libero.it ([193.70.192.52]:34502 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S261576AbRE0TQU>;
	Sun, 27 May 2001 15:16:20 -0400
Message-ID: <3B115279.CE436CEA@alsa-project.org>
Date: Sun, 27 May 2001 21:16:09 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Inconsistent "#ifdef __KERNEL__" on different architectures
In-Reply-To: <Pine.NEB.4.33.0105271903050.4227-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> 
> Hi,
> 
> while looking for the reason of a build failure of the ALSA libraries on
> ARM [1] I discovered the following strange thing:
> 
> On some architectures a function is inside an "#ifdef __KERNEL__" in the
> header file and on others not. Is there a reason for this or is this
> inconsistency simply a bug?

This is a bug on some architectures, I've personally fixed this on PPC
sending a patch to Cort Dougan. It has been included in 2.4.5.

I'd like you send a patch to maintainers (or perhaps to Alan).

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
