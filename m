Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280433AbRKJEYI>; Fri, 9 Nov 2001 23:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280434AbRKJEYA>; Fri, 9 Nov 2001 23:24:00 -0500
Received: from [213.97.184.209] ([213.97.184.209]:4501 "HELO piraos.com")
	by vger.kernel.org with SMTP id <S280433AbRKJEXm>;
	Fri, 9 Nov 2001 23:23:42 -0500
Date: Sat, 10 Nov 2001 05:23:29 +0100
From: German Gomez Garcia <german@piraos.com>
To: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Anyway to disable disk buffers/cache in a particular device?
Message-ID: <20011110052329.A32651@hal9000.piraos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	I would like to know if there is anyway to disable buffering/caching in
a particular device, for example, I have a big 40Mb IDE drive that I use
for video recording and processing, this kind of process just read data and
write it again, buffering is quite useless as the entire file doesn't fit
into memory and it's only read once. I usually run the processing in the
 background as it takes several hours, the problem is that the kernel paged out
almost everything in order to cache most of the file.
	
	Regards,

	- german

PS: Please CC'd to me as I'm not subscribed the the kernel mailing list.
-------------------------------------------------------------------------
German Gomez Garcia          | Send email with "SEND GPG KEY" as subject 
<german@piraos.com>          | to receive my GnuPG public key.
