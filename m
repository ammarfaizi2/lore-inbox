Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbUE3Kjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUE3Kjy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 06:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUE3Kjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 06:39:54 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:62179 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S261932AbUE3Kjm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 06:39:42 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 30 May 2004 12:39:40 +0200
Message-ID: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Vojtech" == Vojtech Pavlik <vojtech@suse.cz> writes:

    Vojtech> On Fri, May 28, 2004 at 04:59:55PM +0300, Tuukka Toivonen
    Vojtech> wrote:
    >> Giuseppe Bilotta wrote: >The new system has some ups and
    >> downs. The biggest "down", >which is that of RAW mode not being
    >> available anymore (it's >emulated!) could be circumvented by
    >> having both the RAW and >translated codes move between layers.
    >> 
    >> Ouch! If the user asks for raw mode, he doesn't get it, but
    >> some emulated mode? To me this sounds like a big
    >> incompatibility.

    Vojtech> Q1: What would you do if the user has an USB keyboard?

If he was  raw mode from a  USB keyboard, he should get  the raw data.
Of course, he should know what he's doing.


    Vojtech> Q2: What application should be looking at the raw data
    Vojtech> outside the kernel and why?

What application should be looking at  the raw data from an RS232 port
outside the kernel and why?

Why do you  leave 'efax' in userspace, letting  it read/write raw data
to/from the modem via the RS232?


    >> Fortunately this patch (written together with Sau Dan Lee)
    >> should give _really_ raw mode in 2.6.x too (but it's not
    >> compatible with the raw mode in 2.4.x):
    >> 
    >> http://www.ee.oulu.fi/~tuukkat/tmp/linux-2.6.5-userdev.20040507.patch
 
In a nutshell, I hate to be restricted by YOUR own imaginations of how
people should hack  the system.

Raw keyboard  data, for  instance, can be  captured for  analyzing how
people use the  keyboard and coming up with  a more efficient keyboard
layout (c.f. Dvorak).  That's already beyond your imaginations.



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

