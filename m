Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313091AbSDGLAX>; Sun, 7 Apr 2002 07:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313093AbSDGLAW>; Sun, 7 Apr 2002 07:00:22 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:15120 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S313091AbSDGLAV>; Sun, 7 Apr 2002 07:00:21 -0400
Date: Sun, 7 Apr 2002 12:00:10 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][RFC][PATCH][CLEANUP] task->state cleanup: pilot
Message-ID: <20020407110010.GA11680@compsoc.man.ac.uk>
In-Reply-To: <20020406220612.GF839@stingr.net> <1018136462.899.119.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
X-Scanner: exiscan *16uAP8-000BUF-00*OzAaBLaainI* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 06, 2002 at 06:41:01PM -0500, Robert Love wrote:

> If anyone can verify where it is safe in this code to use
> __set_current_state instead, speak up so Paul can make the micro
> optimization accordingly.

Ugh, please don't. There is enough mystery as to which one is safe to
use when already.

Is there really a circumstance where avoiding the mb makes a noticable
difference (in driver code, core code is something else ...) ?

john

-- 
"I never understood what's so hard about picking a unique
 first and last name - and not going beyond the 6 character limit."
 	- Toon Moene
