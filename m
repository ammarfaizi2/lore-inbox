Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbUK1SWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbUK1SWF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 13:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbUK1SWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 13:22:05 -0500
Received: from neopsis.com ([213.239.204.14]:47530 "EHLO
	matterhorn.neopsis.com") by vger.kernel.org with ESMTP
	id S261551AbUK1SVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 13:21:51 -0500
Message-ID: <41AA17A8.5040403@dbservice.com>
Date: Sun, 28 Nov 2004 19:23:36 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>, ecki-news2004-05@lina.inka.de,
       linux-kernel@vger.kernel.org
Subject: Re: Problem with ioctl command TCGETS
References: <E1CYMI9-0005PL-00@calista.eckenfels.6bone.ka-ip.net> <E1CYN7z-0001bZ-00@dorka.pomaz.szeredi.hu> <20041128121800.GZ26051@parcelfarce.linux.theplanet.co.uk> <E1CYODw-0001jf-00@dorka.pomaz.szeredi.hu> <20041128124847.GA26051@parcelfarce.linux.theplanet.co.uk> <E1CYOXh-0001nn-00@dorka.pomaz.szeredi.hu> <20041128130319.GB26051@parcelfarce.linux.theplanet.co.uk> <41A9E0FB.8030001@dbservice.com> <20041128152756.GL26051@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041128152756.GL26051@parcelfarce.linux.theplanet.co.uk>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Please contact the ISP for more information
X-Neopsis-MailScanner: Found to be clean
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Sun, Nov 28, 2004 at 03:30:19PM +0100, Tomas Carnecky wrote:
> 
>>You mean.. like nvidia?
>>/dev/nvidiactl
>>/dev/nvidia0
>>/dev/nvidia1
>>/dev/nvidia2
>>and do read/write on /dev/nvidiactl (instead on ioctl)?
> 
> 
> Really depends on situation - in some cases that's the obvious clean
> variant, in some you might want something more specific.

The 'good' thing on ioctl is that _every_ device supports that. It
doesn't matter which device you open, each one supports ioctl.
Now if each driver cooks up it's own replacement.. and everyone
knows that developers don't really like to document their code.. :/

Was there ever a thread on lkml about a ioctl replacement? I'd
really like to read about proposals, so far everyone talks only about
replacing it... but no one wants to say how _exactly_.

tom

