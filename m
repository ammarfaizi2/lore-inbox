Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290737AbSAYRXI>; Fri, 25 Jan 2002 12:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290739AbSAYRWz>; Fri, 25 Jan 2002 12:22:55 -0500
Received: from ns.suse.de ([213.95.15.193]:25357 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290737AbSAYRWm>;
	Fri, 25 Jan 2002 12:22:42 -0500
Date: Fri, 25 Jan 2002 18:22:40 +0100
From: Dave Jones <davej@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Marcel Kunath <kunathma@pilot.msu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Machine Check Exception ?
Message-ID: <20020125182240.I28068@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	Marcel Kunath <kunathma@pilot.msu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20020125114718.7af47375.skraw@ithnet.com> <200201251237.g0PCbOR17328@pilot05.cl.msu.edu> <20020125173623.03923d29.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020125173623.03923d29.skraw@ithnet.com>; from skraw@ithnet.com on Fri, Jan 25, 2002 at 05:36:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 05:36:23PM +0100, Stephan von Krawczynski wrote:

 > It boots and runs for quite a while (weeks), then suddenly freezes and 
 > shows this message.
 > It does not happen often, but very rarely.
 > Has the number any meaning, or is it a goof?

 > > > diehard kernel: CPU 0: Machine Check Exception: 0000000000000004

 This number alone doesn't really tell anything.
 There should be an extra line in the log / on the console,
 which contains two more 64bit numbers. Putting these into
 http://www.codemonkey.org.uk/cruft/parsemce.c will decode
 them and give you more idea hopefully over whats wrong.
 (I really should make that tool a little friendlier ..
  I'll do it soon)
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
