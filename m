Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262568AbUJ0Sxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbUJ0Sxx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 14:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbUJ0Sx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 14:53:27 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:64190 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262569AbUJ0SsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 14:48:23 -0400
Message-ID: <417FED6E.3010007@comcast.net>
Date: Wed, 27 Oct 2004 14:48:14 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Reserving a syscall number
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

How would one go about having a specific syscall number reserved in
entry.S?  I'm exploring doing a kill inside the kernel from a detection
done in userspace, which would allow the executable header of the binary
to indicate whether the task should be killed or not; if it works, the
changes will likely not go into mainline, but will still require a
non-changing syscall index (assuming I understood the syscall manpage
properly).

On a side note, if a syscall doesn't exist, how would that be detected
in userspace?
- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBf+1thDd4aOud5P8RAkeNAJsFJD2l7Up62+/P+SHbJ3l7MwbM0gCfUE/Y
vDgYr0SXlrkrwXZyEZw86QE=
=jmbP
-----END PGP SIGNATURE-----
