Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbULIQlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbULIQlI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 11:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbULIQlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 11:41:07 -0500
Received: from mail.portrix.net ([212.202.157.208]:56218 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261548AbULIQlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 11:41:02 -0500
Message-ID: <41B88007.7060300@ppp0.net>
Date: Thu, 09 Dec 2004 17:40:39 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Glendon Gross <gross@clones.net>
CC: linux-kernel@vger.kernel.org, glendon144@hotmail.com
Subject: Re: Burning CD's and 2.6.9
References: <Pine.NEB.4.44.0412090810570.27084-100000@bsd.clones.net>
In-Reply-To: <Pine.NEB.4.44.0412090810570.27084-100000@bsd.clones.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Glendon Gross wrote:
> I just built 2.6.9 and have been playing with the config to try to enable
> support for my EMPREX 8x DVD burner.  It works exceptionally well under
> 2.4.26.   I can use cdrecord and also growisofs to make audio and data
> DVD's.

> I've set up a lilo config menu to boot 2.6.9 or 2.4.26 because the device
> is not recognized under 2.6.9.    When it is recognized, I get a warning
> that ide-scsi is deprecated for cd recording.

You haven't stated what's wrong with 2.6.9. You know that you can
just use cdrecord dev=/dev/<your ide device name> in 2.6? Without
any SCSI mid-layer. Do you have a specific problem with that?

Jan

