Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278093AbRJKEvT>; Thu, 11 Oct 2001 00:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278096AbRJKEvJ>; Thu, 11 Oct 2001 00:51:09 -0400
Received: from beppo.feral.com ([192.67.166.79]:16143 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S278093AbRJKEu7>;
	Thu, 11 Oct 2001 00:50:59 -0400
Date: Wed, 10 Oct 2001 21:50:11 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: Rick Ellis <ellis@spinics.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: scsi (or fibre channel) target driver
In-Reply-To: <3BC52353.FA707FD2@spinics.net>
Message-ID: <Pine.BSF.4.21.0110102147531.78104-100000@beppo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes- with certain select drivers with ad hoc interfaces. None in the current
tree I believe- although I haven't looked real closely lately.

There was one for aha1540 from years ago, and I've got the stubs of one for
parallel SCSI and Fibre Channe for QLogic cards. Repeat: "stubs"- it's not
completed engineering.

The current SCSI framework doesn't understand incoming commands or what to do
with them, hence the ad hoc nature of all target mode support. FreeBSD's CAM
layer does, btw.

-matt


On Wed, 10 Oct 2001, Rick Ellis wrote:

> Is there a way to have a linux kernel act as a SCSI target?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

