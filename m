Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130073AbRB1HEX>; Wed, 28 Feb 2001 02:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130079AbRB1HED>; Wed, 28 Feb 2001 02:04:03 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:56842 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S130072AbRB1HD4>;
	Wed, 28 Feb 2001 02:03:56 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200102280703.f1S73ft487578@saturn.cs.uml.edu>
Subject: Re: [PATCH][CFT] per-process namespaces for Linux
To: viro@math.psu.edu (Alexander Viro)
Date: Wed, 28 Feb 2001 02:03:41 -0500 (EST)
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0102261137540.79-100000@weyl.math.psu.edu> from "Alexander Viro" at Feb 26, 2001 11:43:47 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:

> 	* CLONE_NEWNS is made root-only (CAP_SYS_ADMIN, actually)

Would an unprivileged version that killed setuid be OK to have?

Evil idea of the day: non-directory (even non-existant) mount points and
non-directory mounts. So then "mount --bind /etc/foo /dev/bar" works.
