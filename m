Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318765AbSHBJhp>; Fri, 2 Aug 2002 05:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318767AbSHBJhp>; Fri, 2 Aug 2002 05:37:45 -0400
Received: from khms.westfalen.de ([62.153.201.243]:33212 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S318765AbSHBJho>; Fri, 2 Aug 2002 05:37:44 -0400
Date: 02 Aug 2002 10:00:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8U5xXb1mw-B@khms.westfalen.de>
In-Reply-To: <20020801203140.A3166@zalem.puupuu.org>
Subject: Re: manipulating sigmask from filesystems and drivers
X-Mailer: CrossPoint v3.12d.kh9 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <20020801203140.A3166@zalem.puupuu.org>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

galibert@pobox.com (Olivier Galibert)  wrote on 01.08.02 in <20020801203140.A3166@zalem.puupuu.org>:

> On Thu, Aug 01, 2002 at 04:30:40PM -0700, Linus Torvalds wrote:
> > And yes, these logging programs are mission-critical, and they do have
> > signals going on, and they rely on well-defined and documented interfaces
> > that say that doing a write() to a filesystem is _not_ going to return in
> > the middle just because a signal came in.
>
> How hard and/or insane would it be to somehow special-case SIGKILL?

Thank you for reading the thread before jumping in.

(Hint: some messages upthread, Linux explained how to do exactly this.)

MfG Kai
