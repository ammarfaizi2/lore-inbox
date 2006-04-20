Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWDTOwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWDTOwN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 10:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWDTOwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 10:52:13 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:27485 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750919AbWDTOwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 10:52:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:subject:x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=t2P6Sg41EpamprF5/A7PO6R9wginryvNPN1reMgROExVn7kCb62tdTMjQtF/QzFVsPWuSIOPptXL1mBRpIPcYcMsNtaYrHb+L3Ze2S0ofLFszc3ENXPfPX9nQkFJJvd/aAkYPbnpnwoazUsEzSU6iBXkacL447f9cGlSDMZNTaY=
Message-ID: <4447A19E.9000008@gmail.com>
Date: Thu, 20 Apr 2006 21:58:38 +0700
From: Mikado <mikado4vn@gmail.com>
Reply-To: mikado4vn@gmail.com
Organization: IcySpace.net
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Which process is associated with process ID 0 (swapper)
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=65ABD897
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

When a process make a connection to one server, if the server doesn't
respond, the swapper process (PID 0) will re-send SYN packet
automatically. How can I know which socket/process that re-sent SYN
packet belongs to.

Thanks in advance,
Mikado.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFER6GeNWc9T2Wr2JcRAsOMAJ9uQze/hsDkzMsXUurVFcbKg/XcUQCgi/1H
c5HttDSP5AboaMe5N4FJPno=
=S8U+
-----END PGP SIGNATURE-----
