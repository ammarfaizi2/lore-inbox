Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbTEKOLp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 10:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbTEKOLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 10:11:45 -0400
Received: from ulima.unil.ch ([130.223.144.143]:25265 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id S261489AbTEKOLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 10:11:44 -0400
Date: Sun, 11 May 2003 16:24:26 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lilo and 2.5.69?
Message-ID: <20030511142426.GB11050@ulima.unil.ch>
References: <20030511130945.GA10607@ulima.unil.ch> <20030511142224.GA16287@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030511142224.GA16287@hh.idb.hist.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11, 2003 at 04:22:24PM +0200, Helge Hafting wrote:

> Looks like a bug that truncates long device names.
> Looks like your'e using devfs, using
> /dev/discs/discX/part2
> is a fine workaround - because it is short enough.
> Replace the X with whatever number your
> host0-target15 disk has.

I have put:

append = "root=/dev/discs/disc2/part2 video=matrox:1600x1200-16@75"

And it produces the same error:

Fatal: open /dev/ide/host0/bus0/target0/lun0/par: No such file or directory     8,1           Top
Exit 1

which was previsible as dev/sdb2 produced the same problem.

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
