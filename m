Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWCLMEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWCLMEh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 07:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWCLMEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 07:04:37 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:25093 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751423AbWCLMEg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 07:04:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nrLId1v/WPX1Dh4NfBNACpbhselLXQJxZKqqHUTFQyXlgr593kNhAeHSVJXkHfcdLo5nvn/osN76SsupdWJzCUuoOD2Jh5R2TTtZb64ZhPwAbaBAGG6KTVn7F2kVnxGQ1sKP514g+DNPTEENzfzCwl+0X+6aJSMJwTTdDndIz2o=
Message-ID: <6bffcb0e0603120404i2640f64dh@mail.gmail.com>
Date: Sun, 12 Mar 2006 13:04:35 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: Linux v2.6.16-rc6
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20060311.183904.71244086.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org>
	 <6bffcb0e0603111751i1ed30794s@mail.gmail.com>
	 <20060311.183904.71244086.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/03/06, David S. Miller <davem@davemloft.net> wrote:
> From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
> Date: Sun, 12 Mar 2006 02:51:40 +0100
>
> > I have noticed this warnings
> > TCP: Treason uncloaked! Peer 82.113.55.2:11759/50967 shrinks window
> > 148470938:148470943. Repaired.
> > TCP: Treason uncloaked! Peer 82.113.55.2:11759/50967 shrinks window
> > 148470938:148470943. Repaired.
> > TCP: Treason uncloaked! Peer 82.113.55.2:11759/59768 shrinks window
> > 1124211698:1124211703. Repaired.
> > TCP: Treason uncloaked! Peer 82.113.55.2:11759/59768 shrinks window
> > 1124211698:1124211703. Repaired.
> >
> > It maybe problem with ktorrent.
>
> It is a problem with the remote TCP implementation, it is
> illegally advertising a smaller window that it previously
> did.
>

Thanks for explanation.

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
