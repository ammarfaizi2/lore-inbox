Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316728AbSEWOVT>; Thu, 23 May 2002 10:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316729AbSEWOVS>; Thu, 23 May 2002 10:21:18 -0400
Received: from srexchimc2.lss.emc.com ([168.159.40.71]:54541 "EHLO
	srexchimc2.lss.emc.com") by vger.kernel.org with ESMTP
	id <S316728AbSEWOVS>; Thu, 23 May 2002 10:21:18 -0400
Message-ID: <FA2F59D0E55B4B4892EA076FF8704F553D1A7A@srgraham.eng.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: linux-kernel@vger.kernel.org
Subject: Poor read performance when sequential write presents
Date: Thu, 23 May 2002 10:20:42 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I did a IO test with one sequential read and one sequential write 
to different files. I expected somewhat similar throughput on read
and write. But it seemed that the read is blocked until the write
finishes. After the write process finished, the read process slowly
picks up the speed. Is Linux buffer cache in favor of write? How
to tune it?


Thanks,

Xiangping Chen
