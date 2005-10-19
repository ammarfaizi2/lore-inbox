Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbVJSUEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbVJSUEx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 16:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVJSUEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 16:04:53 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:53958 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751277AbVJSUEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 16:04:52 -0400
Subject: Re: number of eth0 device
From: Lee Revell <rlrevell@joe-job.com>
To: Mathieu Segaud <matt@regala.cx>
Cc: Erik Mouw <erik@harddisk-recovery.com>,
       Karel Kulhavy <clock@twibright.com>, linux-kernel@vger.kernel.org
In-Reply-To: <87psq1da2j.fsf@barad-dur.minas-morgul.org>
References: <20051019103135.GA9765@kestrel>
	 <20051019104240.GC31526@harddisk-recovery.com>
	 <87psq1da2j.fsf@barad-dur.minas-morgul.org>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 15:34:14 -0400
Message-Id: <1129750454.5203.19.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-19 at 13:23 +0200, Mathieu Segaud wrote:
> well, the way NIC's behave kind of forbids this
> taken from Linux Device Drivers, 3rd Edition, page 497
> "The normal file operations (read, write, and so on) do not make sense
> when applied to network interfaces, so it is not possible to apply the
> Unix ''everything is a file'' approach to them"   
> 

Ditto sound cards, which is why ALSA abandoned the OSS "everything is a
file" paradigm for sound cards.  Read/write etc. don't take into account
the inherent realtime constraints in streaming audio to/from a device.

Lee

