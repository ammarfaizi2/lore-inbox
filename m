Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbUAFPJZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 10:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUAFPJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 10:09:25 -0500
Received: from mail.gmx.de ([213.165.64.20]:60038 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264490AbUAFPJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 10:09:24 -0500
X-Authenticated: #4512188
Message-ID: <3FFACF9C.40001@gmx.de>
Date: Tue, 06 Jan 2004 16:09:16 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: newbiz <newbiz@free.fr>
CC: linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?Karel_Kulhav=FD?= <clock@twibright.com>
Subject: Re: won't work: 2.6.0 && SiI 3112 SATA
References: <20040106135634.A5825@beton.cybernet.src> <S264471AbUAFPAy/20040106150054Z+23529@vger.kernel.org>
In-Reply-To: <S264471AbUAFPAy/20040106150054Z+23529@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Question (for Jeff ?) :
> 
> Why is my drive (with 2.4.23 and libata2) on /dev/sda ? Why isn't it on 
> /dev/hde, like (afaik) everybody else ? I'd like to run hdparm to 
> improve performance (hdparm -tT gives ~ 20 Mb/s)

I am not Jeff but, SATA is embedded SCSI infrastructure, thus you get 
sda device.
Performace is so bad because of workaround for Seagate drives (max 
15kb/transfer or alike). HDParm won't help you.

Prakash
