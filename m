Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263107AbSJBPeF>; Wed, 2 Oct 2002 11:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263109AbSJBPeF>; Wed, 2 Oct 2002 11:34:05 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:51902 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S263107AbSJBPeE>;
	Wed, 2 Oct 2002 11:34:04 -0400
Date: Wed, 2 Oct 2002 16:42:39 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Nick Sanders <sandersn@btinternet.com>
Cc: Stig Brautaset <s.brautaset@wmin.ac.uk>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: 2.5.40: menuconfig: no choice of keyboards
Message-ID: <20021002154239.GB1988@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Nick Sanders <sandersn@btinternet.com>,
	Stig Brautaset <s.brautaset@wmin.ac.uk>,
	linux-kernel@vger.kernel.org, vojtech@suse.cz
References: <20021002113053.GA482@arwen.brautaset.org> <200210021431.25941.sandersn@btinternet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210021431.25941.sandersn@btinternet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 02:31:25PM +0100, Nick Sanders wrote:

 > > Nothing happens if I go to the "Input Device Support" section in
 > > menuconf, and pick "Keyboards"; I get no new options. Got around it by
 > > manually selecting a keyboard in .config to be able to test it further.
 > > Either I chose the wrong one, or it just doesn't build it anyway, 'cause
 > > the machine would not respond on boot.
 > I think you need 'Serial i/o support' just above the 'Keyboards' option

Quite a few people seem to stumble over the new input layer options.
It's non-obvious to quite a few people that serial i/o is anything to
do with their keyboard. Likewise i8042 doesn't ring 'keyboard' noises
in most peoples heads.

IMO, the input layer options need simplification, or at least
a sensible set of defaults.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
