Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267647AbTAMQcV>; Mon, 13 Jan 2003 11:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267812AbTAMQcR>; Mon, 13 Jan 2003 11:32:17 -0500
Received: from mail.comlab.ox.ac.uk ([163.1.27.1]:10513 "EHLO
	mail.comlab.ox.ac.uk") by vger.kernel.org with ESMTP
	id <S267675AbTAMQcO>; Mon, 13 Jan 2003 11:32:14 -0500
Date: Mon, 13 Jan 2003 16:41:03 +0000
From: Ian Collier <Ian.Collier@comlab.ox.ac.uk>
To: linux-laptop@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Dell precision M50 and _very_ slow process startup
Message-ID: <20030113164103.G5472@comlab.ox.ac.uk>
Mail-Followup-To: linux-laptop@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200301131627.h0DGRX101413@rapfast.petcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200301131627.h0DGRX101413@rapfast.petcom.com>; from roe@petcom.com on Mon, Jan 13, 2003 at 10:27:32AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 10:27:32AM -0600, Roe Peterson wrote:
> I'm guessing that this process watches for cd insertion, changes
> to home directory, et. al.

Something like that.  I think it's part of GNOME and is responsible for
making sure there's a CD icon on the screen, or something.

We had a different problem with this beast after installing RH6 some
time ago.  Every few seconds it would cause a spew of messages to the
syslog reporting basically what we knew: there is no CD in the drive.
It turned out though that these messages went away when the CD was
properly reconfigured as a CD-writer by appending "hdc=ide-scsi" to
the boot parameters.  Not that this is at all relevant...

Anyway, no I don't know much about it.

imc
