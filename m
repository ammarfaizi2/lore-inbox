Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287155AbSAHIuU>; Tue, 8 Jan 2002 03:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287375AbSAHIuA>; Tue, 8 Jan 2002 03:50:00 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:62925 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S287177AbSAHIt4>; Tue, 8 Jan 2002 03:49:56 -0500
Message-ID: <3C3AB20A.8B16C23A@programmfabrik.de>
Date: Tue, 08 Jan 2002 09:47:06 +0100
From: Martin Rode <Martin.Rode@programmfabrik.de>
Reply-To: Martin.Rode@programmfabrik.de
Organization: Programmfabrik GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Question about bi-directional pipes.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was just wondering if it is possible under Linux to use popen in a
bi-directional way? I want to use popen under php and must write _and_
read from and to the pipe. Some guy at the php mailing list stated that
this is possible to do with BSD, he wasn't sure about linux.

If this is a kernel issue and not a glibc one, is there a way to get
popen work bi-directionally under linux? Say I want a 

pipe = popen ('somefile', 'w+');

return a valid pipe. As it is now, popen (at least under php, but I
think this should be the same), does not return a handle for mode 'w+'.
It does return a handle only for modes 'r' and 'w'.

Regards,

;Martin


-- 
Dipl.-Kfm. Martin Rode
martin.rode@programmfabrik.de

Programmfabrik GmbH
Frankfurter Allee 73d
10247 Berlin

http://www.programmfabrik.de/

Fon +49-(0)30-4281-8001
Fax +49-(0)30-4281-8008
Funk +49-(0)163-5321400
