Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262642AbTDAQTb>; Tue, 1 Apr 2003 11:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262651AbTDAQRh>; Tue, 1 Apr 2003 11:17:37 -0500
Received: from smtpde01.sap-ag.de ([155.56.68.140]:38881 "EHLO
	smtpde01.sap-ag.de") by vger.kernel.org with ESMTP
	id <S262642AbTDAQQy>; Tue, 1 Apr 2003 11:16:54 -0500
From: Christoph Rohland <cr@sap.com>
To: tomlins@cam.org
Cc: CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
Organisation: Development SAP J2EE Engine
Date: Tue, 01 Apr 2003 18:27:47 +0200
In-Reply-To: <20030401133833.6C71DF3D@oscar.casa.dyndns.org> (Ed Tomlinson's
 message of "Tue, 01 Apr 2003 08:38:32 -0500")
Message-ID: <ovk7eekwsc.fsf@sap.com>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) XEmacs/21.4 (Native Windows TTY
 Support (Windows), cygwin32)
References: <fa.eagpkml.m3elbd@ifi.uio.no>
	<20030401133833.6C71DF3D@oscar.casa.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ed,

On Tue, 01 Apr 2003, Ed Tomlinson wrote:
> What does tmpfs have to do with ram size?  Its swappable.  This
> _might_ be useful for ramfs but for tmpfs, IMHO, its not a good
> idea.

I agree and I think if you add this option it should adjust to a
percentage of (ram + swap). With this it would be a really nice
improvement.
I even had patches for this but to do it efficently you would need to
add some hooks to swapon and swapoff.

Greetings
		Christoph


