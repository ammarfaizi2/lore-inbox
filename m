Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282682AbRK0AgO>; Mon, 26 Nov 2001 19:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282679AbRK0AgH>; Mon, 26 Nov 2001 19:36:07 -0500
Received: from rigel.neo.shinko.co.jp ([210.225.91.71]:10627 "EHLO
	rigel.neo.shinko.co.jp") by vger.kernel.org with ESMTP
	id <S282683AbRK0Afr>; Mon, 26 Nov 2001 19:35:47 -0500
Message-ID: <3C02DFDC.F433EBD3@neo.shinko.co.jp>
Date: Tue, 27 Nov 2001 09:35:40 +0900
From: nakai <nakai@neo.shinko.co.jp>
X-Mailer: Mozilla 4.78 [ja] (WinNT; U)
X-Accept-Language: ja,en,pdf
MIME-Version: 1.0
To: Jonathan Kamens <jik@kamens.brookline.ma.us>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE: 2.2.19+IDE patches works fine; 2.4.x fails miserably;please 
 help me figure out why!
In-Reply-To: <200111250457.fAP4vIt03205@jik.kamens.brookline.ma.us>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Kamens wrote:
> For months now, I've been trying every 2.4.x kernel as it comes out.
> Every time, I start getting IDE errors shortly after booting into the
> 2.4.x kernel.  My filesystems aren't totally trashed, but lots of the
> new data being written to the filesystems are trashed and I have to
> fix a bunch of errors with fsck and recreate those trashed new files
> after reverting to my 2.2.19 kernel (to which I have applied Andre's
> IDE patches).

Would you try 2.4.2 ?  Some ide-pci code related with promise were
changed between 2.4.2 and 2.4.10. I also had a problem in 2.4.10 
with promise.

But I needed to run 2.4.10, because 2.4.10 support promise 100tx2
(pdc20268 chip). 2.4.2 dosen't suport promise 100tx2. I had to
edit ide-pci code. It works with no problem, but I'm not sure
it is correct. If you want to run >2.4.10, I will send you diffs.
 
-- 
-=-=-=-=  SHINKO ELECTRIC INDUSTRIES CO., LTD.           =-=-=-=-
=-=-=-=-    Core Technology Research & Laboratory,       -=-=-=-=
-=-=-=-=      Infomation Technology Research Dept.       =-=-=-=-
=-=-=-=-  Name:Hisakazu Nakai          TEL:026-283-2866  -=-=-=-=
-=-=-=-=  Mail:nakai@neo.shinko.co.jp  FAX:026-283-2820  =-=-=-=-
