Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUANPkX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 10:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbUANPkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 10:40:23 -0500
Received: from smtp.ncy.finance-net.fr ([62.161.220.65]:10765 "EHLO
	smtp.ncy.finance-net.fr") by vger.kernel.org with ESMTP
	id S261606AbUANPkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 10:40:19 -0500
Date: Wed, 14 Jan 2004 16:40:09 +0100
From: newbiz <newbiz@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031015 Debian/1.4-0jds2
X-Accept-Language: fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: won't work: 2.6.0 && SiI 3112 SATA
References: <20040106135634.A5825@beton.cybernet.src> <S264471AbUAFPAy/20040106150054Z+23529@vger.kernel.org> <3FFACF9C.40001@gmx.de>
In-Reply-To: <3FFACF9C.40001@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Message-Id: <S261606AbUANPkT/20040114154019Z+29922@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I finally tried siimage with 2.6 (2.6.1-mm2) and hdparm -tT gives about
55 MB/s (~ 20 with libata)

I had understood that libata was better than siimage with non-seagate
drives, and that both were as bad with seagate drives. Has libata been
improved since this time ?

Thanks
--


Prakash K. Cheemplavam a écrit le 06.01.2004 16:09:
> 
>> Why is my drive (with 2.4.23 and libata2) on /dev/sda ? Why isn't
>> it on /dev/hde, like (afaik) everybody else ? I'd like to run
>> hdparm to improve performance (hdparm -tT gives ~ 20 Mb/s)
> 
> I am not Jeff but, SATA is embedded SCSI infrastructure, thus you get
> sda device. Performace is so bad because of workaround for Seagate
> drives (max 15kb/transfer or alike). HDParm won't help you.

