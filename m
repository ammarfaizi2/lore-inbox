Return-Path: <linux-kernel-owner+w=401wt.eu-S1760740AbWLHOOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760740AbWLHOOr (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 09:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760742AbWLHOOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 09:14:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:33744 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760741AbWLHOOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 09:14:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QAvNNOiOpM3azJ+e6GRvLDmFHxsDZTr8oEHdGV7FgzlwuqWwf9837jYLGWEmqx2ScYph+eivcZfw0c/zZzh4Jm/A/SaeXbtlbVFAVG8z+NA+SHsUB6WJ+x4pc3rKKCP/jDG3YvbrUc1Pc3N3tYFHxKPYh086FHN/c5QWNLQhXNg=
Message-ID: <d120d5000612080614l3c4c5b1cy9437c2a43c2853dd@mail.gmail.com>
Date: Fri, 8 Dec 2006 09:14:43 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Jiri Kosina" <jkosina@suse.cz>
Subject: Re: [git pull] Input patches for 2.6.19
Cc: "Linus Torvalds" <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Greg KH" <gregkh@suse.de>,
       "Marcel Holtmann" <marcel@holtmann.org>
In-Reply-To: <Pine.LNX.4.64.0612081038520.1665@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612080157.04822.dtor@insightbb.com>
	 <Pine.LNX.4.64.0612081038520.1665@twin.jikos.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/8/06, Jiri Kosina <jkosina@suse.cz> wrote:
> On Fri, 8 Dec 2006, Dmitry Torokhov wrote:
>
> > Hi Linus,
> > Please pull from:
> > git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
> > or
> > master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git
> > to receive updates for input subsystem.
> >  b/drivers/usb/input/hid-core.c                 |    7
> >  b/drivers/usb/input/hid-input.c                |    4
> >  b/drivers/usb/input/hid.h                      |    1
>
> OK, this is going to break the merge from Greg's tree of generic HID
> layer, which was planned for today.
>
> The merge will probably emit a large .rej files, due to the large blocks
> of code being moved around, but it seems that most of the changes which
> would conflict with the merge could be trivially solved by hand.
>
> Greg, should I prepare a new version of the generic HID patches against
> merged Linus' + Dmitry's trees and send them to you?
>

Hmm, I thought that git would take care of resolving the merge
conflict but it was 2AM thought and obviously not a smart one. Sorry.

-- 
Dmitry
