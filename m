Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276956AbRKXLhr>; Sat, 24 Nov 2001 06:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277012AbRKXLhj>; Sat, 24 Nov 2001 06:37:39 -0500
Received: from ns1.bodhidharma.org ([212.98.68.66]:26885 "EHLO ns1.khidr.net")
	by vger.kernel.org with ESMTP id <S276988AbRKXLhX>;
	Sat, 24 Nov 2001 06:37:23 -0500
Message-ID: <3BFF8692.7060900@vegaa.de>
Date: Sat, 24 Nov 2001 12:37:54 +0100
From: Michael Zimmermann <zim@vegaa.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org
Subject: Re: Moving ext3 journal file
In-Reply-To: <E167Fuw-00001K-00@DervishD> <20011123155901.C1308@lynx.no> <9tmocg$jfn$1@cesium.transmeta.com> <20011123174120.Q1308@lynx.no> <9tmr83$jo2$1@cesium.transmeta.com> <20011123212557.U1308@lynx.no> <3BFF2AAE.7000000@zytor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excuse me, if I jump in with almost zero linux-kernel-knowledge,
and take my words as a third-party comment.

May be, I've not seen enough in 35 years of system programming
(including designing and writing journal-systems my own),
but I've never seen a journal beeing part of the data-space to be
journalled. It is simply an ugly thing in the file space. It either belongs
into /proc/fs/ext3 (or the like) or is not to be shown at all. Except
there was a valid neccessity to have it in the normal file space.


Greetings
Michael

