Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264518AbTL0R3L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 12:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbTL0R3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 12:29:11 -0500
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:61560 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264518AbTL0R3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 12:29:08 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Tomas Szepe <szepe@pinerecords.com>
Subject: Re: Synaptics problems in -mm1
Date: Sat, 27 Dec 2003 12:28:58 -0500
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, GCS <gcs@lsc.hu>,
       linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>
References: <20031224095921.GA8147@lsc.hu> <200312250414.58598.dtor_core@ameritech.net> <20031227113848.GA10491@louise.pinerecords.com>
In-Reply-To: <20031227113848.GA10491@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312271228.59192.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 December 2003 06:38 am, Tomas Szepe wrote:
> Hi,
>
> it seems one of the synaptics-related patches in 2.6.0-mm1 kills
> off the pointer stick on my T40p.  2.6.0 vanilla works just fine
> in that department.  Thought you might want to know.
>
> Reverting
>
> 	input-08-synaptics-protocol-discovery.patch
> 	input-07-remove-synaptics-config-option.patch
> 	synaptics-powerpro-fix.patch
>
> did not seem to help.  I failed to figure out a way to easily revert
>
> 	serio-06-synaptics-use-reconnect.patch
> 	serio-04-synaptics-cleanup.patch
>
> so that I didn't try.

I have a couple of questions (I am not familiar with IBM hardware so
please bear with me...):
- Is it detected as Synaptics but does not work?
- Should it be detected as Synaptics?
- Does it work if you pass psmouse_noext=1 or psmouse_proto=bare?
  And what about psmouse_proto=imps and psmouse_proto=exps
- Does it work if you give 2.6.0-test10-mm1 a quick boot?
- dmesg, input section of you XFree and version and parameters that
  are passed to GPM.

Thank you,

Dmitry
