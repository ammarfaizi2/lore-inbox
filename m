Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289324AbSA2KHG>; Tue, 29 Jan 2002 05:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289328AbSA2KG4>; Tue, 29 Jan 2002 05:06:56 -0500
Received: from 217-126-161-163.uc.nombres.ttd.es ([217.126.161.163]:8590 "EHLO
	DervishD.viadomus.com") by vger.kernel.org with ESMTP
	id <S289324AbSA2KGo>; Tue, 29 Jan 2002 05:06:44 -0500
To: ebiederm@xmission.com, raul@viadomus.com
Subject: Re: Why 'linux/fs.h' cannot be included? I *can*...
Cc: linux-kernel@vger.kernel.org
Message-Id: <E16VVMw-0001oa-00@DervishD.viadomus.com>
Date: Tue, 29 Jan 2002 11:20:02 +0100
From: DervishD <raul@viadomus.com>
Reply-To: DervishD <raul@viadomus.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hello Eric :)

>>     This header can be included or not? It works for me, with headers
>> from 2.4.17, so, is it just for backwards compatibility?
>Policy.  It is for forwards compatibility. The general policy on kernel
>headers is that if it breaks you get to keep the pieces.

    That is: I can include it if I just want the definition of a few
ioctl's, but if in a future version all that is changed or even
dissapears is completely my problem.

    Given the number of user-space apps that needs ioctl definitions
and things like those (that are supposed not to change easily), those
definitions should go in user-includable headers... IMHO.

    Fortunately, we have some of them in libc headers now.

    Thanks,
    Raúl
