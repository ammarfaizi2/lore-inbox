Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291592AbSBHPBn>; Fri, 8 Feb 2002 10:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291597AbSBHPBf>; Fri, 8 Feb 2002 10:01:35 -0500
Received: from ns.suse.de ([213.95.15.193]:61454 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291592AbSBHPB2>;
	Fri, 8 Feb 2002 10:01:28 -0500
Date: Fri, 8 Feb 2002 15:57:33 +0100
From: Dave Jones <davej@suse.de>
To: Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.4-pre3] link error in drivers/video/video.o
Message-ID: <20020208155733.F32413@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200202081520.29475@bilbo.math.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200202081520.29475@bilbo.math.uni-mannheim.de>; from eike@bilbo.math.uni-mannheim.de on Fri, Feb 08, 2002 at 03:22:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 03:22:00PM +0100, Rolf Eike Beer wrote:

 > drivers/video/video.o(.text.init+0x13f9): undefined reference to 
 > `bus_to_virt_not_defined_use_pci_map'
 > make: *** [vmlinux] Error 1

 As the variable name suggests, a driver you compiled needs to be
 updated to use a new API.  If you're not able to tackle this
 yourself, give 2.5.3-dj4 a shot, and use CONFIG_DEBUG_OBSOLETE=n
 Not ideal, but should get you running again at least, until someone
 has a chance to update it.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
