Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290127AbSAQSlc>; Thu, 17 Jan 2002 13:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290133AbSAQSlV>; Thu, 17 Jan 2002 13:41:21 -0500
Received: from smtp1.ndsu.NoDak.edu ([134.129.111.146]:43022 "EHLO
	smtp1.ndsu.nodak.edu") by vger.kernel.org with ESMTP
	id <S290127AbSAQSlG>; Thu, 17 Jan 2002 13:41:06 -0500
Subject: Re: safest verion of gcc to use?
From: Reid Hekman <reid.hekman@ndsu.nodak.edu>
To: kelley eicher <carde@astro.umn.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020117121923.A7977@astro.umn.edu>
In-Reply-To: <20020117121923.A7977@astro.umn.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 17 Jan 2002 12:39:20 -0600
Message-Id: <1011292762.31205.24.camel@zeus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-17 at 12:19, kelley eicher wrote:
> quick question here. [kernel-src]/Documentation/Changes and
> [kernel-src]/README say two different things about which version of gcc
> is recommended for the compiling of the linux kernel. README says egcs
> 1.1.2 and Documentation/Changes says to use gcc 2.95.3 or greater.
> is the last egcs release still the preferred or has that changed to the
> gcc 2.95.x releases?

Yes, Documentation/Changes is more correct. For i386, 2.95.[34] and
2.96-[>=85] work fine. GCC 3.0.3 should work too, though some drivers
have had difficulties and earlier 3.x releases generated some ICE's.
Other architectures may vary.

./README and ./Documentation/Changes need some trimming...

Regards,
Reid

