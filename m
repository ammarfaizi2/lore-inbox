Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286224AbRLTMYi>; Thu, 20 Dec 2001 07:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286222AbRLTMYa>; Thu, 20 Dec 2001 07:24:30 -0500
Received: from jubjub.wizard.com ([209.170.216.9]:52996 "EHLO
	jubjub.wizard.com") by vger.kernel.org with ESMTP
	id <S286220AbRLTMYU>; Thu, 20 Dec 2001 07:24:20 -0500
Date: Thu, 20 Dec 2001 04:24:14 -0800
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 'eject' process stuck in "D" state
Message-ID: <20011220122414.GA507@wizard.com>
In-Reply-To: <20011220111249.GA15692@wizard.com> <20011220122325.A710@suse.de> <20011220113654.GA1271@wizard.com> <20011220123904.B710@suse.de> <20011220120750.GA1429@wizard.com> <20011220131116.C710@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20011220131116.C710@suse.de>
User-Agent: Mutt/1.3.23.2i
X-Operating-System: Linux/2.5.1-dj3 (i686)
X-uptime: 4:17am  up 4 min,  2 users,  load average: 0.15, 0.17, 0.07
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-PGP-Keys: see http://www.omnilinx.net/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 20, 2001 at 01:11:16PM +0100, Jens Axboe wrote:
> On Thu, Dec 20 2001, A Guy Called Tyketto wrote:
> > In the messages file, I've taken it from the initial time I saw the problem, 
> 
> _Please_, grab them from _dmesg_, things are getting cut...

        Just getting to that. as I brought down the box, I got some errors on 
/dev/tty1, which are the same from dmesg. 'ere ya go.

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Description: dmesg
Content-Disposition: attachment; filename="REQB.txt"

root@bellicha:~# dmesg
D REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
ide-cd bad flags: dev 0: REQ_BARRIER REQ_STARTED REQ_BLOCK_PC 
root@bellicha:~# 

--CE+1k2dSO48ffgeK--
