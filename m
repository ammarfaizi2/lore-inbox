Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129450AbQL0LdC>; Wed, 27 Dec 2000 06:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130109AbQL0Lcx>; Wed, 27 Dec 2000 06:32:53 -0500
Received: from fw-cam.cambridge.arm.com ([193.131.176.3]:17390 "EHLO
	fw-cam.cambridge.arm.com") by vger.kernel.org with ESMTP
	id <S129450AbQL0Lcj>; Wed, 27 Dec 2000 06:32:39 -0500
Message-Id: <4.3.2.7.2.20001227110018.00e5ba90@cam-pop.cambridge.arm.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 27 Dec 2000 11:01:18 +0000
To: Arnaud Installe <ainstalle@filepool.com>
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@arm.com>
Subject: Re: high load & poor interactivity on fast thread creation
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001130171137.A1851@bartok.filepool.com>
In-Reply-To: <3A266895.F522A0E2@austin.ibm.com>
 <20001130081443.A8118@bach.iverlek.kotnet.org>
 <3A266895.F522A0E2@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:11 PM 11/30/00, Arnaud Installe wrote:
>Could this be correct ?  Also, I haven't seen this happen with NT.  Could
>it be that Java on NT uses user-mode threading and creates threads much
>more slowly, resulting in a lower load ?

No. Java on NT uses proper NT threads. However, a thread on NT is a rather 
different beast to a cloned thread on Linux. I don't know whether the 
differences are important.

Ruth
-- 

Ruth 
Ivimey-Cook                       ruthc@sharra.demon.co.uk
Technical 
Author, ARM Ltd              ruth.ivimey-cook@arm.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
