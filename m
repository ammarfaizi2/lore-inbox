Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280814AbRLQQoL>; Mon, 17 Dec 2001 11:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281214AbRLQQoB>; Mon, 17 Dec 2001 11:44:01 -0500
Received: from mail.spylog.com ([194.67.35.220]:56227 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S280814AbRLQQnm>;
	Mon, 17 Dec 2001 11:43:42 -0500
Date: Mon, 17 Dec 2001 19:15:38 +0300
From: Andrey Nekrasov <andy@spylog.ru>
To: Hubert Mantel <mantel@suse.de>, linux-kernel@vger.kernel.org
Subject: amber/mars & ext3
Message-ID: <20011217161538.GA17099@spylog.ru>
Mail-Followup-To: Hubert Mantel <mantel@suse.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

1. /dev/ide/host0/bus1/target0/lun0/part1 on /b1 type ext3
(rw,noatime,errors=remount-ro)

2. dmesg

...
end_request: I/O error, dev 16:01 (hdc), sector 4160
end_request: I/O error, dev 16:01 (hdc), sector 4160
end_request: I/O error, dev 16:01 (hdc), sector 4160
end_request: I/O error, dev 16:01 (hdc), sector 4160
end_request: I/O error, dev 16:01 (hdc), sector 4160
end_request: I/O error, dev 16:01 (hdc), sector 4160
end_request: I/O error, dev 16:01 (hdc), sector 4160
end_request: I/O error, dev 16:01 (hdc), sector 4160
end_request: I/O error, dev 16:01 (hdc), sector 4160
end_request: I/O error, dev 16:01 (hdc), sector 4160
end_request: I/O error, dev 16:01 (hdc), sector 4160
EXT3-fs error (device ide1(22,1)): ext3_readdir: directory #2 contains a hole at
offset 0
end_request: I/O error, dev 16:01 (hdc), sector 4160
EXT3-fs error (device ide1(22,1)): ext3_readdir: directory #2 contains a hole at
offset 0
end_request: I/O error, dev 16:01 (hdc), sector 4160
EXT3-fs error (device ide1(22,1)): ext3_readdir: directory #2 contains a hole at
offset 0
end_request: I/O error, dev 16:01 (hdc), sector 4160
EXT3-fs error (device ide1(22,1)): ext3_readdir: directory #2 contains a hole at
offset 0
end_request: I/O error, dev 16:01 (hdc), sector 4160
...

2. 

2.4.16.SuSE-0

3. 

/dev/ide/host0/bus1/target0/lun0/part1
                       70G   55G   16G  77% /b1
4.

amber:/b1 # ls -la /b1
total 0
amber:/b1 #

-- 
bye.
Andrey Nekrasov, SpyLOG.
