Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315754AbSEDAYp>; Fri, 3 May 2002 20:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315755AbSEDAYo>; Fri, 3 May 2002 20:24:44 -0400
Received: from CPE-203-51-25-114.nsw.bigpond.net.au ([203.51.25.114]:12787
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S315754AbSEDAYo>; Fri, 3 May 2002 20:24:44 -0400
Message-ID: <3CD32A4A.D8E86725@eyal.emu.id.au>
Date: Sat, 04 May 2002 10:24:42 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa1 & vm-34: blkmtd.c compile failure
In-Reply-To: <20020503203738.E1396@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> Full patchkit:
> http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre8aa1.gz

'struct kiobuf' does not have a member 'blocks', used in two places.

Should it use 'kio_blocks'?

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
