Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293242AbSCVH6v>; Fri, 22 Mar 2002 02:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293244AbSCVH6m>; Fri, 22 Mar 2002 02:58:42 -0500
Received: from ns.suse.de ([213.95.15.193]:4880 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293242AbSCVH6d>;
	Fri, 22 Mar 2002 02:58:33 -0500
Date: Fri, 22 Mar 2002 08:58:28 +0100
From: Dave Jones <davej@suse.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
        torvalds@transmeta.com
Subject: Re: [PATCH] boot_cpu_data corruption on SMP x86
Message-ID: <20020322085828.P22861@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Mikael Pettersson <mikpe@csd.uu.se>, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
	torvalds@transmeta.com
In-Reply-To: <200203212117.WAA22504@harpo.it.uu.se> <Pine.GSO.3.96.1020322002809.1646C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2002 at 12:36:02AM +0100, Maciej W. Rozycki wrote:
 > If say the BSP supports cpuid but an AP does not (possible for an
 > i486 setup)

 It's also possible on any SMP aware system, but with the warning
 "you use asymetric CPUs, you get to keep the pieces". I don't recall
 486's being any exception to this rule.
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
