Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbTJTTKb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 15:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbTJTTKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 15:10:31 -0400
Received: from main.gmane.org ([80.91.224.249]:23989 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262768AbTJTTKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 15:10:30 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
Date: Mon, 20 Oct 2003 21:08:16 +0200
Message-ID: <yw1xekx7afrz.fsf@kth.se>
References: <20031020141512.GA30157@hell.org.pl> <yw1x8yngj7xg.fsf@users.sourceforge.net>
 <20031020184750.GA26154@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:dvEtAah0xPU7x84DCY9vmDWI0EE=
Cc: acpi-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karol Kozimor <sziwan@hell.org.pl> writes:

>> suspend, the extra buttons (I use them to fire up programs) stop
>> working.  Normally, they will generate an ACPI event, that is
>> processed by acpid etc.  After a suspend, each button will work once.
>> If I then close and open the lid, they will work one more time, and so
>> on.  Any way I can help?
>
> Please specify the type of suspend. The situation I described only occurs
> for S1 (or, echo -n standby, more specifically), and only in certain kernel
> versions.

standby, at least.

After echo -n mem > /sys/power/state, the display light won't turn on,
so I don't know what's going on.  I've never managed to resume from a
suspend to disk.  It just boots normally and makes a fuss about the
filesystems.

-- 
Måns Rullgård
mru@kth.se

