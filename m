Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbTDGLsg (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 07:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbTDGLsg (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 07:48:36 -0400
Received: from smtpde02.sap-ag.de ([155.56.68.170]:16614 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP id S263387AbTDGLsf (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 07:48:35 -0400
From: Christoph Rohland <cr@sap.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       CaT <cat@zip.com.au>, <tomlins@cam.org>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
Organisation: Development SAP J2EE Engine
Date: Mon, 07 Apr 2003 13:59:17 +0200
In-Reply-To: <Pine.LNX.4.44.0304071245130.1130-100000@localhost.localdomain> (Hugh
 Dickins's message of "Mon, 7 Apr 2003 12:55:59 +0100 (BST)")
Message-ID: <ov3ckuldre.fsf@sap.com>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) XEmacs/21.4 (Native Windows TTY
 Support (Windows), cygwin32)
References: <Pine.LNX.4.44.0304071245130.1130-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

On Mon, 7 Apr 2003, Hugh Dickins wrote:
> You're supposing that it's tmpfs causing this problem: not at all,
> that's just an easy way to show it.  Take away tmpfs, and swapoff
> is still liable to hang, with other tasks OOMing (even when strict
> no-overcommit accounting: I've not yet added the check it needs).

No, I know tmpfs is not faulty :-)

But the hook would give tmpfs the chance to say stop before the mm
layer even tries to do something and where it actually fails to do it
right.

Greetings
		Christoph


