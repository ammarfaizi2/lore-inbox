Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262212AbTCRIse>; Tue, 18 Mar 2003 03:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262228AbTCRIse>; Tue, 18 Mar 2003 03:48:34 -0500
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:27823 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S262212AbTCRIsd>; Tue, 18 Mar 2003 03:48:33 -0500
From: "BOEBLINGEN LINUX390" <LINUX390@de.ibm.com>
Importance: Normal
Sensitivity: 
Subject: Re: [s390x] Patch for execve with a mode switch
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFA75E38A6.F16CA542-ONC1256CED.00308E93@de.ibm.com>
Date: Tue, 18 Mar 2003 09:57:47 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 18/03/2003 09:59:09
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pete,
>I still think you are making a mistake defininig your own
>arch_get_unmapped_area(), because: 1. sparc64 does it correctly
>with the common code, so it can be done; 2. architecture
>specific duplicates of common code may bitrot. But have it
>your way, I won't resubmit, for the sake of staying aligned
>with upstream.

I am not too happy with the arch_get_unmapped_area myself. I not
happpy with the TIF_ABI_PENDING bit either, there has to be a
way to do this in a simply and straighforward way.
I'll keep thinking about it.

blue skies,
  Martin.


