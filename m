Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313238AbSD0Lmn>; Sat, 27 Apr 2002 07:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313261AbSD0Lmm>; Sat, 27 Apr 2002 07:42:42 -0400
Received: from ns.suse.de ([213.95.15.193]:19215 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313238AbSD0Lmm>;
	Sat, 27 Apr 2002 07:42:42 -0400
Date: Sat, 27 Apr 2002 13:42:41 +0200
From: Dave Jones <davej@suse.de>
To: Matthew M <matthew.macleod@btinternet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Microcode update driver
Message-ID: <20020427134241.H14743@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Matthew M <matthew.macleod@btinternet.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <m171QRZ-000Ga6C@Wasteland>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2002 at 12:32:42PM +0100, Matthew M wrote:
 > -----BEGIN PGP SIGNED MESSAGE-----
 > Hash: SHA1
 > 
 > Hi,
 > 
 > When I try to update the microcode on my PIV (1.7GHz, Jetway mobo), the 
 > update fails and i see --
 > 
 > microcode: CPU0 no microcode found! (sig=f0a, pflags=4)

Probably the microcode.dat file has no updated microcode for this
stepping of CPU.  Make sure you have the latest one from
http://www.urbanmyth.org/microcode/

But it's still possible that there is no update (yet).

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
