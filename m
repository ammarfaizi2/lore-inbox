Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbTFQSvy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 14:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264890AbTFQSvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 14:51:54 -0400
Received: from main.gmane.org ([80.91.224.249]:47548 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264884AbTFQSvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 14:51:52 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: John Goerzen <jgoerzen@complete.org>
Subject: 2.4.21 packet writing?
Date: Tue, 17 Jun 2003 13:48:57 -0500
Organization: Complete.Org
Message-ID: <87d6hczgiu.fsf@complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@complete.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:JuMsp7hkRZwB0oJcTrw0f+2Ufhc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been using the packet writing patches floating around for some
time, and find them very useful.  I have modified slightly a recent
one to work with 2.4.21-rc8.  It worked with the IDE CD-ROM driver
(that is, /dev/hdc), but with the ide-scsi driver at /dev/scd0, it
would read but threw up a write error every time a modification was
attempted.

Has anyone made a packet writing patch compatible with 2.4.21 that
works with ide-scsi?

My workaround to date has been to unload the ide-scsi module and
insert the IDE cdrom module when I want to use packet writing, and do
the reverse when I want to use cdrecord.  It's quite annoying and I'd
rather just use one device the whole time.

Thanks,
John Goerzen

