Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267491AbTGQB1X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 21:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271310AbTGQB1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 21:27:23 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:63492 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S267491AbTGQB1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 21:27:22 -0400
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 sound drivers?
References: <20030716225826.GP2412@rdlg.net>
	<20030716231029.GG1821@matchmail.com> <20030716233045.GR2412@rdlg.net>
	<3F15E3C9.4030401@blue-labs.org> <20030717000804.GT2412@rdlg.net>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <20030717000804.GT2412@rdlg.net>
Date: 16 Jul 2003 21:42:02 -0400
Message-ID: <m365m2gc9h.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Robert" == Robert L Harris <Robert.L.Harris@rdlg.net> writes:

Robert> No go, it looks like it's playing but nothing to the speakers.

Alsa boots up muted.  Use alsamixer(1) (it is a curses app) to set
your prefered volumes.  Then as root run 'alsactl store' to store
said volumes.  Each boot running 'alsactl restore' will reset them.

-JimC

