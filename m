Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUE3KpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUE3KpK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 06:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUE3KpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 06:45:10 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:13028 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S262071AbUE3KpE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 06:45:04 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Tuukka Toivonen <tuukkat@ee.oulu.fi>, linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 30 May 2004 12:45:02 +0200
Message-ID: <xb7n03qb3dd.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Vojtech" == Vojtech Pavlik <vojtech@suse.cz> writes:

    On Sat, May 29, 2004 at 03:23:20PM +0200, Andries Brouwer
    >> Thanks for the report. It shows that resurrecting raw mode is
    >> even more desirable than I thought at first.

    Vojtech> What for?

For more imaginative innovations.

e.g. try my keyboard driver across 2 machines (using the SERIO_USERDEV
patch from Tuukka Toivonen and me):

    master$ cat /dev/misc/isa0060/serio0 | ssh slave atkbd /proc/self/fd/0

The patch is here:
    http://www.ee.oulu.fi/~tuukkat/tmp/linux-2.6.5-userdev.20040507.patch

The driver is here:
    http://www.informatik.uni-freiburg.de/~danlee/fun/psaux/atkbd.c

(I haven't  tried this, as  I don't have  2 machines under  my control
(==root) to try it out.  Please tell me the results.)



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

