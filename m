Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265241AbUD3Tx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265241AbUD3Tx5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 15:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265242AbUD3Tx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 15:53:57 -0400
Received: from piedra.unizar.es ([155.210.11.65]:7324 "EHLO relay.unizar.es")
	by vger.kernel.org with ESMTP id S265241AbUD3Txz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 15:53:55 -0400
Date: Fri, 30 Apr 2004 21:53:51 +0200
From: Jorge Bernal <koke_lkml@amedias.org>
To: linux-kernel@vger.kernel.org
Subject: strange delays on console logouts (tty != 1)
Message-ID: <20040430195351.GA1837@amedias.org>
Reply-To: koke@amedias.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since some days ago I'm using the console more than X and I have a
strange problem.

On tty's != 1 it takes a long time (~20-30 secs) from logout to next
login but on tty1 it takes a normal time.

If I launch getty on tty9 and logout (in tty9) getty ends inmediately
and I can start it again and get another login.

I'm not sure if it actually has something to do with the kernel (maybe
with /sbin/init). dmesg doesn't say anything about that.

Thanks,
	Koke

-- 
"Sólo el éxito diferencia al genio del loco"

Blog: http://www.amedias.org/koke
Web Personal: http://sindominio.net/~koke/
JID: koke@zgzjabber.ath.cx
