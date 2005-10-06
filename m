Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbVJFVLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbVJFVLd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 17:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbVJFVLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 17:11:33 -0400
Received: from qproxy.gmail.com ([72.14.204.194]:8134 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751363AbVJFVLc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 17:11:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JItPkzIhq4N2S68SdY928MkAKP6inkhawLeP79ghsdIWLwB5qHBsjMpZGn06SWjHrb0590C5eUBsRxg96PJk6gRMEmDCIL2jziQyhgUcRQa0fAobcxgv0tcGeicB3YCqDCWLsAZrW3V0wvRlSVtq90nX2gSrQd7GxFiyRksBgUU=
Message-ID: <fb3f6bf10510061411i7af556a1x8c5f22c478d89229@mail.gmail.com>
Date: Thu, 6 Oct 2005 17:11:31 -0400
From: Larry Lindsey <larry.the.pirate@gmail.com>
Reply-To: Larry Lindsey <larry.the.pirate@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.27 ata_piix support
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've created a patch created against Debain's 2.4.27 kernel sources,
which adds ata_piix support to the 2.4.27 kernel.  Its pretty klugey,
but at this point it at least *seems* to work.  Here's a link.

http://www.math.gatech.edu/~lindsey/libata-piix-2.4.27.patch.tar.bz2

It is a combination of one of Jeff Garzik's patches and the scsi code
from the 2.4.31 kernel.  I've probably broken about 2 million
principles with respect to code maintenance.

I bet some of you are wondering why in the world I would do this.  I
did find a half dozen patches that were previously posted to this
list, but I couldn't get any of them to work correctly, starting from
the 2.4.27 source.  For various reasons, I'm stuck with that
particular kernel.  I'm posting because I'm hoping that this might be
useful to other people in a similar situation.
