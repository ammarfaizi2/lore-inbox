Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262785AbSJCHhI>; Thu, 3 Oct 2002 03:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263118AbSJCHhI>; Thu, 3 Oct 2002 03:37:08 -0400
Received: from mailsrv1.sweco.se ([194.16.71.76]:58007 "EHLO
	es-sth-002.sweco.se") by vger.kernel.org with ESMTP
	id <S262785AbSJCHhH>; Thu, 3 Oct 2002 03:37:07 -0400
Message-ID: <E50A0EFD91DBD211B9E40008C75B6CCA01497EDE@ES-STH-012>
From: Eriksson Stig <stig.eriksson@sweco.se>
To: "'Justin T. Gibbs'" <gibbs@scsiguy.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: aic7xxx problems?
Date: Thu, 3 Oct 2002 09:42:31 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 
> >> Hi
> >> 
> >> Maybe You can help me out with this one...
> >> I have hp DLT connected to an adaptec SCSI board.
> > 
> > From the perspective of the controller, the target has taken the
> > full command but has yet to REQ for either a cdb transfer retry
> > or a new phase.  This looks like a target problem or a cabling
> > problem that prevents the initiator from seeing a REQ or two.
> 
> Actually, in reviewing your message more fully, the problem is that
> the timeout for the rewind operation is too short for your 
> configuration.
> The timeout should go away if you bump up the timeout in the st driver
> so that your tape drive can rewind in peace.

The rewind is not *that* long, about 60 seconds...

--
Stig Eriksson
