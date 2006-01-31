Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWAaPfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWAaPfd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 10:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWAaPfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 10:35:33 -0500
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:11524 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1750981AbWAaPfc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 10:35:32 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Kurt Garloff <garloff@suse.de>
Subject: Re: Rescan SCSI Bus without /proc/scsi?
Date: Tue, 31 Jan 2006 14:44:05 +0000
User-Agent: KMail/1.9
Cc: Andreas Schwab <schwab@suse.de>,
       Nico Schottelius <nico-kernel@schottelius.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <20051031110344.GA16691@schottelius.org> <je4q6y547h.fsf@sykes.suse.de> <20060131135125.GB9188@tpkurt.wlan.garloff.de>
In-Reply-To: <20060131135125.GB9188@tpkurt.wlan.garloff.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601311444.06019.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 January 2006 13:51, Kurt Garloff wrote:
> Hi,
>
> On Mon, Oct 31, 2005 at 12:13:54PM +0100, Andreas Schwab wrote:
> > Nico Schottelius <nico-kernel@schottelius.org> writes:
> > > This breaks the popular rescan-scsi-bus.sh from Kurt Garloff.
> > > Is there a possibility to do that through /sys somehow or do I have
> > > to reanable /proc/scsi?
> >
> > Your version of rescan-scsi-bus.sh is quite old.  Current versions of
> > rescan-scsi-bus.sh already use /sys when available.
>
> Attached for reference.

>From the attachment;

if test ! -d /proc/scsi/; then
  echo "Error: SCSI subsystem not active"
  exit 1
fi

:-)

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
